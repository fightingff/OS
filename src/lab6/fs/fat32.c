#include "fat32.h"
#include "printk.h"
#include "virtio.h"
#include "string.h"
#include "mbr.h"
#include "mm.h"

struct fat32_bpb fat32_header;
struct fat32_volume fat32_volume;

uint8_t fat32_buf[VIRTIO_BLK_SECTOR_SIZE];
uint8_t fat32_table_buf[VIRTIO_BLK_SECTOR_SIZE];

uint64_t cluster_to_sector(uint64_t cluster) {
    return (cluster - 2) * fat32_volume.sec_per_cluster + fat32_volume.first_data_sec;
}

uint32_t next_cluster(uint64_t cluster) {
    uint64_t fat_offset = cluster * 4;
    uint64_t fat_sector = fat32_volume.first_fat_sec + fat_offset / VIRTIO_BLK_SECTOR_SIZE;
    virtio_blk_read_sector(fat_sector, fat32_table_buf);
    int index_in_sector = fat_offset % (VIRTIO_BLK_SECTOR_SIZE / sizeof(uint32_t));
    return *(uint32_t*)(fat32_table_buf + index_in_sector);
}

void fat32_init(uint64_t lba, uint64_t size) {
    virtio_blk_read_sector(lba, (void*)&fat32_header);
    fat32_volume.first_fat_sec = fat32_header.rsvd_sec_cnt; // reserved sectors 0~(rsvd_sec_cnt-1)
    fat32_volume.sec_per_cluster = fat32_header.sec_per_clus; // sectors per cluster
    fat32_volume.first_data_sec = fat32_header.rsvd_sec_cnt + fat32_header.num_fats * fat32_header.fat_sz32; // first data sector
    fat32_volume.fat_sz = fat32_header.fat_sz32; // fat size
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
    struct fat32_file file;
    /* todo: open the file according to path */
    return file;
}

int64_t fat32_lseek(struct file* file, int64_t offset, uint64_t whence) {
    if (whence == SEEK_SET) {
        file->cfo = 0/* to calculate */;
    } else if (whence == SEEK_CUR) {
        file->cfo = 0/* to calculate */;
    } else if (whence == SEEK_END) {
        /* Calculate file length */
        file->cfo = 0/* to calculate */;
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
    struct fat32_file *fat32_file = &file->fat32_file;
    uint64_t bytes_read = 0;
    uint8_t sector_buf[VIRTIO_BLK_SECTOR_SIZE];

    while (len > 0) {
        // 计算当前簇号和簇内偏移量
        uint64_t cluster = fat32_file->cluster;
        uint64_t cluster_offset = file->cfo % (fat32_volume.sec_per_cluster * VIRTIO_BLK_SECTOR_SIZE);

        // 计算当前扇区号和扇区内偏移量
        uint64_t sector = cluster_to_sector(cluster) + (cluster_offset / VIRTIO_BLK_SECTOR_SIZE);
        uint64_t sector_offset = cluster_offset % VIRTIO_BLK_SECTOR_SIZE;

        // 读取当前扇区
        virtio_blk_read_sector(sector, sector_buf);

        // 计算本次读取的字节数
        uint64_t bytes_to_read = VIRTIO_BLK_SECTOR_SIZE - sector_offset;
        if (bytes_to_read > len) {
            bytes_to_read = len;
        }

        // 将数据复制到缓冲区
        memcpy(buf + bytes_read, sector_buf + sector_offset, bytes_to_read);

        // 更新偏移量和剩余长度
        bytes_read += bytes_to_read;
        file->cfo += bytes_to_read;
        len -= bytes_to_read;

        // 如果当前簇的数据已经读完，移动到下一个簇
        if (file->cfo % (fat32_volume.sec_per_cluster * VIRTIO_BLK_SECTOR_SIZE) == 0) {
            fat32_file->cluster = next_cluster(fat32_file->cluster);
        }
    }

    return bytes_read;
}

int64_t fat32_write(struct file* file, const void* buf, uint64_t len) {
    /* todo: fat32_write */
    return 0;
}