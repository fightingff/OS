#include "vm.h"
#include "mm.h"
#include "defs.h"
#include "string.h"
#include "stdint.h"
#include "trap.h"
#include "printk.h"
#include "clock.h"
#include "proc.h"
#include "syscall.h"
#include "fs.h"

extern struct task_struct *current;

int64_t sys_write(uint64_t fd, const char *buf, uint64_t len) {
    int64_t ret;
    struct file *file = &(current->files->fd_array[fd]);
    if (file->opened == 0) {
        printk("file not opened\n");
        return ERROR_FILE_NOT_OPEN;
    } else {
        // check perms and call write function of file
        if (file->perms & FILE_WRITABLE) {
            ret = file->write(file, buf, len);
        } else {
            printk("file not writable\n");
            return ERROR_FILE_NOT_WRITABLE;
        }
    }
    return ret;
}

int64_t sys_read(uint64_t fd, char *buf, uint64_t len) {
    int64_t ret;
    struct file *file = &(current->files->fd_array[fd]);
    if (file->opened == 0) {
        printk("file not opened\n");
        return ERROR_FILE_NOT_OPEN;
    } else {
        // check perms and call read function of file
        if (file->perms & FILE_READABLE) {
            ret = file->read(file, buf, len);
        } else {
            printk("file not readable\n");
            return ERROR_FILE_NOT_WRITABLE;
        }
    }
    return ret;
}

int64_t sys_lseek(int64_t fd, int64_t offset, int64_t whence) {
    struct file *file = &(current->files->fd_array[fd]);

    if (file->opened == 0) {
        printk("file not opened\n");
        return ERROR_FILE_NOT_OPEN;
    } else {
        // 不需要判断权限
        int64_t ret = file->lseek(file, offset, whence);
        return ret;
    }
}

// 打开文件
// dfd 在当前程序中没用
// filename 其实是 path
int64_t sys_openat(int64_t dfd, const char *filename, int64_t flags) {
    ASSERT(dfd == AT_FDCWD);
    // 找到空闲的文件描述符
    uint64_t fd = MAX_FILE_NUMBER;
    for (uint64_t i = 0; i < MAX_FILE_NUMBER; i++) {
        if (current->files->fd_array[i].opened) {
            continue;
        } else {
            fd = i;
            break;
        }
    }
    ASSERT(fd < MAX_FILE_NUMBER);

    // init
    int64_t ret = file_open(&current->files->fd_array[fd], filename, flags);
    ASSERT(ret != -1);
    return ret;
}

// 关闭文件
int64_t sys_close(int64_t fd) {
    ASSERT(fd >= 0 && fd < MAX_FILE_NUMBER);
    current->files->fd_array[fd].opened = 0;
    return 0; // 返回值没用上
}



void trap_handler(uint64_t scause, uint64_t sepc, struct pt_regs *regs) {
    // 通过 `scause` 判断 trap 类型
    // 如果是 interrupt 判断是否是 timer interrupt
    // 如果是 timer interrupt 则打印输出相关信息，并通过 `clock_set_next_event()` 设置下一次时钟中断
    // `clock_set_next_event()` 见 4.3.4 节
    // 其他 interrupt / exception 可以直接忽略，推荐打印出来供以后调试

    bool is_interrupt = ((scause & SCAUSE_INTERRUPT) > 0);
    uint64_t exception_code = scause & (~SCAUSE_INTERRUPT);

    if(is_interrupt && exception_code == SCAUSE_INT_TIMER) {
        // Supervisor software interrupt from a S-mode timer interrupt 时钟中断
        // 打印输出相关信息
        // printk("[S] Supervisor Mde Timer Interrupt\n");
        // 设置下一次时钟中断
        clock_set_next_event();
        // schedule
        do_timer();
    } else if(!is_interrupt && exception_code == SCAUSE_EXC_U_ECALL) {
        if(regs->x[17] == SYS_GETPID) {
            regs->x[10] = current->pid;
            LOG(GREEN "ecall: SYS_GETPID, pid = %d" CLEAR, current->pid);
        } else if(regs->x[17] == SYS_WRITE) {
            LOG(GREEN "ecall: SYS_WRITE" CLEAR);
            regs->x[10] = sys_write(regs->x[10], (const char *)regs->x[11], regs->x[12]);
        } else if (regs->x[17] == SYS_CLONE) {
            LOG(GREEN "ecall: SYS_CLONE" CLEAR);
            regs->x[10] = do_fork(regs);
            LOG(GREEN "ecall: SYS_CLONE, child_pid = %llu\n" CLEAR, regs->x[10]);
        } else if (regs->x[17] == SYS_READ) {
            LOG(GREEN "ecall: SYS_READ" CLEAR);
            regs->x[10] = sys_read(regs->x[10], (char *)regs->x[11], regs->x[12]);
        } else if (regs->x[17] == SYS_OPENAT) {
            LOG(GREEN "ecall: SYS_OPENAT" CLEAR);
            regs->x[10] = sys_openat(regs->x[10], (const char *)regs->x[11], regs->x[12]);
        } else if (regs->x[17] == SYS_CLOSE) {
            LOG(GREEN "ecall: SYS_CLOSE" CLEAR);
            regs->x[10] = sys_close(regs->x[10]);
        } else if (regs->x[17] == SYS_LSEEK) {
            LOG(GREEN "ecall: SYS_LSEEK" CLEAR);
            regs->x[10] = sys_lseek(regs->x[10], regs->x[11], regs->x[12]);
        } else {
            printk("[U] Unhandled ecall: ecall_type=%016llX \n", regs->x[17]);
        }
        regs->sepc += 4;
    } else if(!is_interrupt && (
        exception_code == SCAUSE_EXC_INSTRUCTION_PAGE_FAULT
        || exception_code == SCAUSE_EXC_LOAD_PAGE_FAULT
        || exception_code == SCAUSE_EXC_STORE_OR_AMO_PAGE_FAULT
    )) {
        // 处理 PAGE_FAULT, 进行 Demand Paging
        /** 当触发 page fault 异常, stval 寄存器中会保存触发异常的虚拟地址
         * If stval is written with a nonzero value when a breakpoint, address-misaligned, access-fault, or page fault exception occurs on an instruction fetch, load, or store, then stval will contain the faulting virtual address.
         */
        
        uint64_t bad_addr = csr_read(stval);
        LOG(GREEN "page fault! bad_addr = %016llX, exc = %d" CLEAR, bad_addr, exception_code);
        struct vm_area_struct *vma = find_vma(&current->mm, bad_addr);
        
        ASSERT(vma != NULL);
        ASSERT(!(exception_code == SCAUSE_EXC_INSTRUCTION_PAGE_FAULT && !(vma->vm_flags & VM_EXEC)));

        uint64_t *pte = find_pte(current->pgd, bad_addr);
        LOG(GREEN "find pte = %p" CLEAR, pte);

        if(exception_code == SCAUSE_EXC_STORE_OR_AMO_PAGE_FAULT
            && (vma->vm_flags & VM_WRITE) 
            && pte != NULL && !(*pte & 0x4)
        ) {
            // LOG(GREEN "copy on write!" CLEAR);
            uint64_t *src_page = (uint64_t *)PA2VA(*pte >> 10 << 12);
            // uint64_t *src_page = (uint64_t *)(bad_addr & ~0xFFF);
            // LOG(GREEN "src_page = %p" CLEAR, src_page);
            uint64_t ref_cnt = get_page_refcnt(src_page);
            ASSERT(ref_cnt > 0);

            if(ref_cnt == 1) {
                // PTE_W 改成 1 即可 
                *pte |= 0x4;
            } else {
                uint64_t *page = (uint64_t *)alloc_page();
                memcpy(page, src_page, PGSIZE);
                *pte = ((uint64_t)VA2PA(page) >> 12 << 10) | (*pte & 0x3FF);
                *pte |= 0x4;
                put_page(src_page);
                // LOG(GREEN "*pte = %016LLX" CLEAR, *pte);
            }
            // flush TLB and icache
            asm volatile("sfence.vma zero, zero");
            asm volatile("fence.i");
        } else {
            do_map_one_page(current->pgd, vma, bad_addr);
        }
    } else {
        // 其他 interrupt / exceptiont
        printk("[S] Unhandled interrupt/exception: scause=0x%lx, sepc=0x%lx\n", scause, sepc);
    }
}