#include "fat32.h"
#include "printk.h"
#include "virtio.h"
#include "string.h"
#include "mbr.h"
#include "mm.h"
#include "fs.h"

struct fat32_bpb fat32_header;
struct fat32_volume fat32_volume;

uint64_t cluster_to_sector(uint64_t cluster) {
    return (cluster - 2) * fat32_volume.sec_per_cluster + fat32_volume.first_data_sec;
}

uint32_t next_cluster(uint64_t cluster) {
    static uint8_t fat32_table_buf[VIRTIO_BLK_SECTOR_SIZE];

    uint64_t fat_offset = cluster * 4;
    uint64_t fat_sector = fat32_volume.first_fat_sec + fat_offset / VIRTIO_BLK_SECTOR_SIZE;
    virtio_blk_read_sector(fat_sector, fat32_table_buf);
    int index_in_sector = fat_offset % (VIRTIO_BLK_SECTOR_SIZE / sizeof(uint32_t));
    return *(uint32_t *)(fat32_table_buf + index_in_sector);
}

void fat32_init(uint64_t lba, uint64_t size) {
    LOG("fat32_init: lba: %llu, size: %llu", lba, size);
    virtio_blk_read_sector(lba, (void*)&fat32_header);
    fat32_volume.first_fat_sec = lba + fat32_header.rsvd_sec_cnt; // reserved sectors 0~(rsvd_sec_cnt-1)
    fat32_volume.sec_per_cluster = fat32_header.sec_per_clus; // sectors per cluster
    fat32_volume.first_data_sec = lba + fat32_header.rsvd_sec_cnt + fat32_header.num_fats * fat32_header.fat_sz32; // first data sector
    fat32_volume.fat_sz = fat32_header.fat_sz32; // fat size

    LOG("first_fat_sec: %llu", fat32_volume.first_fat_sec);
    LOG("sec_per_cluster: %u", fat32_volume.sec_per_cluster);
    LOG("first_data_sec: %llu", fat32_volume.first_data_sec);
    LOG("fat_sz: %u", fat32_volume.fat_sz);
}

int is_fat32(uint64_t lba) {
    virtio_blk_read_sector(lba, (void*)&fat32_header);
    if (fat32_header.boot_sector_signature != 0xaa55) {
        return 0;
    }
    return 1;
}

int next_slash(const char* path) {  // util function to be used in fat32_open_file
    int i = 0;
    while (path[i] != '\0' && path[i] != '/') {
        i++;
    }
    if (path[i] == '\0') {
        return -1;
    }
    return i;
}

void to_upper_case(char *str) {     // util function to be used in fat32_open_file
    for (int i = 0; str[i] != '\0'; i++) {
        if (str[i] >= 'a' && str[i] <= 'z') {
            str[i] -= 32;
        }
    }
}

struct fat32_file fat32_open_file(const char *path) {
    static uint8_t fat32_buf[VIRTIO_BLK_SECTOR_SIZE];

    struct fat32_file file;
    /* todo: open the file according to path */
    // 得到文件名位置
    LOG("path: %s", path);
    int i, t = -1;
    do {
        i += t + 1;
        t = next_slash(path + i);
    }while(~t);

    LOG();
    // 提取大写文件名
    char name[strlen(path + i) + 2];
    memcpy(name, path + i, strlen(path + i) + 1);
    to_upper_case(name);
    LOG("name: %s", name);

    // 读取根目录
    /**
     * DIR_Name[0] = 0xE5 indicates the directory entry is free (available). 
     * DIR_Name[0] = 0x00 also indicates the directory entry is free (available). However, DIR_Name[0] = 0x00 is an additional indicator that all directory entries following the current free entry are also free.
     */
    
    uint32_t cluster = fat32_header.root_clus;
    for (; cluster != CLUSTER_END; cluster = next_cluster(cluster)){
        uint64_t dir_sec = cluster_to_sector(cluster); // 扇区号
        for (int k = 0; k < fat32_volume.sec_per_cluster; k++, dir_sec++) {// 读取每个扇区
            LOG("cluster: %u, dir_sec: %llu", cluster, dir_sec);
            virtio_blk_read_sector(dir_sec, fat32_buf);
            for (int i = 0; i < FAT32_ENTRY_PER_SECTOR; i++) {
                struct fat32_dir_entry *entry = (struct fat32_dir_entry *)(fat32_buf + i * sizeof(struct fat32_dir_entry));
                if (entry->name[0] == 0x00) { // all free
                    break;
                }
                if (entry->name[0] == 0xe5) { // free
                    continue;
                }
                if (memcmp(entry->name, name, strlen(name)) == 0) {
                    file.cluster = (entry->starthi << 16) | entry->startlow;
                    file.dir.cluster = cluster;
                    file.dir.index = FAT32_ENTRY_PER_SECTOR * k + i;
                    return file;
                }
            }
        }
    }

    file.cluster = CLUSTER_END;
    return file;
}

void fat32_get_dir_entry(const struct fat32_dir *fat32_dir, struct fat32_dir_entry *entry) {
    static uint8_t fat32_dir_entry_buf[VIRTIO_BLK_SECTOR_SIZE];

    uint64_t dir_cluster_first_sec = cluster_to_sector(fat32_dir->cluster);
    uint64_t dir_sec = dir_cluster_first_sec + fat32_dir->index / FAT32_ENTRY_PER_SECTOR;
    uint64_t dir_i = fat32_dir->index % FAT32_ENTRY_PER_SECTOR; // sec 中的第几个

    virtio_blk_read_sector(dir_sec, fat32_dir_entry_buf);
    *entry = *(struct fat32_dir_entry *)(fat32_dir_entry_buf + dir_i * sizeof(struct fat32_dir_entry));
}

int64_t fat32_lseek(struct file* file, int64_t offset, uint64_t whence) {
    if (whence == SEEK_SET) {
        file->cfo = offset;
    } else if (whence == SEEK_CUR) {
        file->cfo += offset;
    } else if (whence == SEEK_END) {
        /* Calculate file length */
        struct fat32_dir_entry entry;
        fat32_get_dir_entry(&file->fat32_file.dir, &entry);
        file->cfo = entry.size + offset;
    } else {
        printk("fat32_lseek: whence not implemented\n");
        while (1);
    }
    return file->cfo;
}

uint64_t fat32_table_sector_of_cluster(uint32_t cluster) {
    return fat32_volume.first_fat_sec + cluster / (VIRTIO_BLK_SECTOR_SIZE / sizeof(uint32_t));
}

int64_t fat32_read(struct file* file, void* buf, uint64_t len) {
    const uint64_t cluster_size = fat32_volume.sec_per_cluster * VIRTIO_BLK_SECTOR_SIZE;
    uint8_t sector_buf[VIRTIO_BLK_SECTOR_SIZE];

    struct fat32_dir_entry entry; 
    fat32_get_dir_entry(&file->fat32_file.dir, &entry);
    ASSERT(file->cfo <= entry.size);
    len = MIN(len, entry.size - file->cfo);

    // 先跳到 cfo 所在的簇
    uint64_t cluster = file->fat32_file.cluster;
    for (uint64_t i = 1; i * cluster_size <= file->cfo; i++) {
        cluster = next_cluster(cluster);
        ASSERT(cluster != CLUSTER_END);
    }

    // 只需要同时维护 cfo 和 簇    
    uint64_t bytes_read = 0; // 已经读取的字节数
    while (bytes_read < len) {
        ASSERT(cluster != CLUSTER_END);

        // 簇内偏移量
        uint64_t cluster_offset = file->cfo % cluster_size;

        // 计算当前扇区号和扇区内偏移量
        uint64_t sector = cluster_to_sector(cluster) + (cluster_offset / VIRTIO_BLK_SECTOR_SIZE);
        uint64_t sector_offset = cluster_offset % VIRTIO_BLK_SECTOR_SIZE;

        // 读取当前扇区
        virtio_blk_read_sector(sector, sector_buf);

        // 计算本次读取的字节数
        uint64_t bytes_to_read = MIN(VIRTIO_BLK_SECTOR_SIZE - sector_offset, len - bytes_read);
        // 将数据复制到缓冲区
        memcpy(buf + bytes_read, sector_buf + sector_offset, bytes_to_read);

        // 更新偏移量和剩余长度
        bytes_read += bytes_to_read;
        file->cfo += bytes_to_read;

        // 如果当前簇的数据已经读完，移动到下一个簇
        if (cluster_offset + bytes_to_read >= cluster_size) {
            cluster = next_cluster(cluster);
        }
    }
    return bytes_read;
}

int64_t fat32_write(struct file* file, const void* buf, uint64_t len) {
    /* todo: fat32_write */
    const uint64_t cluster_size = fat32_volume.sec_per_cluster * VIRTIO_BLK_SECTOR_SIZE;
    uint8_t sector_buf[VIRTIO_BLK_SECTOR_SIZE];

    struct fat32_dir_entry entry; 
    fat32_get_dir_entry(&file->fat32_file.dir, &entry);
    ASSERT(file->cfo <= entry.size);
    len = MIN(len, entry.size - file->cfo);

    // 先跳到 cfo 所在的簇
    uint64_t cluster = file->fat32_file.cluster;
    for (uint64_t i = 1; i * cluster_size <= file->cfo; i++) {
        cluster = next_cluster(cluster);
        ASSERT(cluster != CLUSTER_END);
    }

    // 只需要同时维护 cfo 和 簇    
    uint64_t bytes_written = 0; // 已经读取的字节数
    while (bytes_written < len) {
        ASSERT(cluster != CLUSTER_END);

        // 簇内偏移量
        uint64_t cluster_offset = file->cfo % cluster_size;

        // 计算当前扇区号和扇区内偏移量
        uint64_t sector = cluster_to_sector(cluster) + (cluster_offset / VIRTIO_BLK_SECTOR_SIZE);
        uint64_t sector_offset = cluster_offset % VIRTIO_BLK_SECTOR_SIZE;
        // 计算本次写入的字节数
        uint64_t bytes_to_write = MIN(VIRTIO_BLK_SECTOR_SIZE - sector_offset, len - bytes_written);

        // 如果写入的占满整个扇区，那就不用读取，直接写入
        // 否则，读取、修改 再 写入
        if (sector_offset == 0 && bytes_to_write == VIRTIO_BLK_SECTOR_SIZE) {
            memcpy(sector_buf, buf + bytes_written, bytes_to_write);
            virtio_blk_write_sector(sector, sector_buf);
        } else {
            // 先读取当前扇区
            virtio_blk_read_sector(sector, sector_buf);
            // 修改
            memcpy(sector_buf + sector_offset, buf + bytes_written, bytes_to_write);
            // 写入
            virtio_blk_write_sector(sector, sector_buf);
        }

        // 更新偏移量和剩余长度
        bytes_written += bytes_to_write;
        file->cfo += bytes_to_write;

        // 如果当前簇的数据已经读完，移动到下一个簇
        if (cluster_offset + bytes_to_write >= cluster_size) {
            cluster = next_cluster(cluster);
        }
    }
    return bytes_written;
}