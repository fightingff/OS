#include "mm.h"
#include "vm.h"
#include "defs.h"
#include "proc.h"
#include "string.h"
#include "stdlib.h"
#include "printk.h"
#include "elf.h"

extern void __dummy();
extern uint64_t swapper_pg_dir[512];

struct task_struct *idle;           // idle process
struct task_struct *current;        // 指向当前运行线程的 task_struct
struct task_struct *task[NR_TASKS]; // 线程数组，所有的线程都保存在此

// 用户程序的代码段
extern char _sramdisk[], _eramdisk[];


/**
 * 几种 flag 格式: （最后几位的高位到低位）
 * SV39 perm:   U | X | W | R | V
 * elf p_flags:         R | W | X
 * VM flag:         X | W | R | A 
 * 下面给出相互转换的函数
 */

uint64_t vm_flags_to_perm(uint64_t vm_flags) {
    uint64_t perm = (1 << 4) | 1;
    perm |= (vm_flags & 0b1110);
    return perm;
}

// 一个我加的小函数，将 elf 文件的 flags 变为 SV39 的 perm
// 自动加上 U 和 V
uint64_t p_flags_to_perm(uint64_t p_flags) {
    uint64_t perm = (1 << 4) | 1;
    perm |= ((p_flags & 0x4) >> 1) | ((p_flags & 0x2) << 1) | ((p_flags & 0x1) << 3);
    return perm;
}

uint64_t p_flags_to_vm_flags(uint64_t p_flags, bool anon) {
    uint64_t perm = 0x0;
    if(anon) perm |= VM_ANON;
    perm |= ((p_flags & 0x4) >> 1) | ((p_flags & 0x2) << 1) | ((p_flags & 0x1) << 3);
    return perm;
}

void load_program(struct task_struct *task) {
    Elf64_Ehdr *ehdr = (Elf64_Ehdr *)_sramdisk;
    Elf64_Phdr *phdrs = (Elf64_Phdr *)(_sramdisk + ehdr->e_phoff);
    for (int i = 0; i < ehdr->e_phnum; ++i) {
        Elf64_Phdr *phdr = phdrs + i;
        if (phdr->p_type == PT_LOAD) {
            // do mapping
            uint64_t user_app_page_offset = (uint64_t)(_sramdisk + phdr->p_offset) & 0xfff;
            uint64_t user_app_mem = phdr->p_memsz + user_app_page_offset;
            uint64_t user_app_pages_count = user_app_mem / PGSIZE + (user_app_mem % PGSIZE != 0);

            do_mmap(&task->mm, PGROUNDDOWN(phdr->p_vaddr), user_app_pages_count * PGSIZE, phdr->p_offset, phdr->p_filesz, p_flags_to_vm_flags(phdr->p_flags, false));
        }
    }
    task->thread.sepc = ehdr->e_entry;
}

// 查找包含虚拟地址 addr 的 vma 项
struct vm_area_struct *find_vma(struct mm_struct *mm, uint64_t addr) {
    struct vm_area_struct *cur = mm->mmap;
    for(; cur != NULL; cur = cur->vm_next) {
        if(cur->vm_start <= addr && addr < cur->vm_end) {
            return cur;
        }
    }
    return NULL;
}

uint64_t do_mmap(struct mm_struct *mm, uint64_t addr, uint64_t len, uint64_t vm_pgoff, uint64_t vm_filesz, uint64_t flags) {
    // len 必须是对齐后的，而且是整页
    ASSERT((len & 0xFFF) == 0);
    ASSERT((addr & 0xFFF) == 0);

    struct vm_area_struct *vma = (struct vm_area_struct *)alloc_page();
    vma->vm_mm = mm;
    vma->vm_start = addr;
    vma->vm_end = addr + len;
    vma->vm_pgoff = vm_pgoff;
    vma->vm_filesz = vm_filesz;
    vma->vm_flags = flags;

    // 插入表头
    vma->vm_next = mm->mmap;
    mm->mmap = vma;

    vma->vm_prev = NULL;
    if(vma->vm_next) {
        vma->vm_next->vm_prev = vma;
    }
}

void do_map_one_page(uint64_t *pgd, struct vm_area_struct *vma, uint64_t bad_addr) {
    ASSERT(vma != NULL);
    ASSERT(vma->vm_start <= bad_addr && bad_addr <= vma->vm_end);

    // 首先先变成虚拟地址上的 pgd
    pgd = (uint64_t *)((uint64_t)pgd + PA2VA_OFFSET);

    uint64_t va = PGROUNDDOWN(bad_addr);
    uint64_t perm = vm_flags_to_perm(vma->vm_flags);

    // 申请一页用于映射
    uint8_t *page = alloc_page();
    memset(page, 0, PGSIZE);

    uint64_t page_offset = (vma->vm_pgoff & 0xFFF);

    LOG(GREEN "do_map_one_page: va = %llx, bad_addr = %llx" CLEAR, va, bad_addr);

    // 如果是匿名空间，则直接映射空页即可
    if(vma->vm_flags & VM_ANON) {
        LOG(GREEN "do_map_one_page: VM_ANON" CLEAR);
        create_mapping(pgd, va, (uint64_t)page - PA2VA_OFFSET, PGSIZE, perm);
        return;
    }

    // 否则不是匿名空间，要从外部 load
    // 总体来看
    // 第一段: [vm_start, page_offset) 0
    // 第二段: [vm_start + page_offset, vm_start + page_offset + filesz) copy
    // 第三段: [vm_start + page_offset + filesz, vm_end) 0

    // 用该页和第二段取交集即可，因为其他都是 0
    uint64_t vm_l = MAX(vma->vm_start + page_offset, va);
    uint64_t vm_r = MIN(vma->vm_start + page_offset + vma->vm_filesz, va + PGSIZE);
    uint64_t pm_offset = vma->vm_pgoff + (vm_l - (vma->vm_start + page_offset));
    LOG(GREEN "do_map_one_page: vm_l = %llx, vm_r = %llx" CLEAR, vm_l, vm_r);

    if(vm_l < vm_r) {
        memcpy(page + (vm_l - va), _sramdisk + pm_offset, vm_r - vm_l);
    }

    create_mapping(pgd, va, (uint64_t)page - PA2VA_OFFSET, PGSIZE, perm);
}


void task_init() {
    srand(2024);

    // 1. 调用 kalloc() 为 idle 分配一个物理页
    idle = (struct task_struct *)kalloc();

    // 2. 设置 state 为 TASK_RUNNING;
    idle->state = TASK_RUNNING;

    // 3. 由于 idle 不参与调度，可以将其 counter / priority 设置为 0
    idle->counter = idle->priority = 0;

    // 4. 设置 idle 的 pid 为 0
    idle->pid = 0;

    // 5. 将 current 和 task[0] 指向 idle
    current = task[0] = idle;

    // 1. 参考 idle 的设置，为 task[1] ~ task[NR_TASKS - 1] 进行初始化
    // 2. 其中每个线程的 state 为 TASK_RUNNING, 此外，counter 和 priority 进行如下赋值：
    //     - counter  = 0;
    //     - priority = rand() 产生的随机数（控制范围在 [PRIORITY_MIN, PRIORITY_MAX] 之间）
    // 3. 为 task[1] ~ task[NR_TASKS - 1] 设置 thread_struct 中的 ra 和 sp
    //     - ra 设置为 __dummy（见 4.2.2）的地址
    //     - sp 设置为该线程申请的物理页的高地址

    /*
    对于每个进程，初始化我们刚刚在 thread_struct 中添加的三个变量，具体而言：
        - 将 sepc 设置为 USER_START
        - 配置 sstatus 中的 SPP（使得 sret 返回至 U-Mode）、SPIE（sret 之后开启中断）、SUM（S-Mode 可以访问 User 页面）
        - 将 sscratch 设置为 U-Mode 的 sp，其值为 USER_END （将用户态栈放置在 user space 的最后一个页面）
    
    对于每个进程，创建属于它自己的页表：
        - 为了避免 U-Mode 和 S-Mode 切换的时候切换页表，我们将内核页表 swapper_pg_dir 复制到每个进程的页表中
        - 将 uapp 所在的页面映射到每个进程的页表中
    */

    /* YOUR CODE HERE */

    for(int i = 1; i < NR_TASKS; ++i) {
        task[i] = (struct task_struct *)kalloc();
        task[i]->state = TASK_RUNNING;

        task[i]->counter = 0;
        task[i]->priority = PRIORITY_MIN + rand() % (PRIORITY_MAX - PRIORITY_MIN + 1);

        task[i]->pid = i;

        task[i]->thread.ra = (uint64_t)__dummy;
        task[i]->thread.sepc = USER_START;

        /**
         * 配置 sstatus 中的 SPP（使得 sret 返回至 U-Mode）、SPIE（sret 之后开启中断）、SUM（S-Mode 可以访问 User 页面）
         * SPP 置 0: When an SRET instruction (see Section 3.3.2) is executed to return from the trap handler, the privilege level is set to user mode if the SPP bit is 0, or supervisor mode if the SPP bit is 1; SPP is then set to 0.
         * SPIE 置 1: The SPIE bit indicates whether supervisor interrupts were enabled prior to trapping into supervisor mode. When a trap is taken into supervisor mode, SPIE is set to SIE, and SIE is set to 0. When an SRET instruction is executed, SIE is set to SPIE, then SPIE is set to 1
         * SUM 置 1
         */
        task[i]->thread.sstatus = csr_read(sstatus);
        task[i]->thread.sstatus &= ~(1ull << SPP);
        task[i]->thread.sstatus |= (1ull << SPIE);
        task[i]->thread.sstatus |= (1ull << SUM);

        // 一个 page 4KiB，刚好是 512 个 64 bit，刚好是一级页表的大小
        task[i]->pgd = alloc_page();

        printk("task[%d]->pgd = %p\n", i, task[i]->pgd);
        // 先复制一遍内核态的页表
        memcpy(task[i]->pgd, swapper_pg_dir, 512 * 8);

        // 使用 ELF 格式 load 程序到 vma
        load_program(task[i]);

        // 构建并映射用户栈
        // 开一个 page 作为用户栈, 由于 demand paging, 只需把这个映射加入 vma
        uint64_t va = USER_END - PGSIZE;
        do_mmap(&task[i]->mm, va, PGSIZE, 0, 0, VM_ANON | VM_READ | VM_WRITE);

        // 转为物理地址
        task[i]->pgd = (uint64_t *)((uint64_t)task[i]->pgd - PA2VA_OFFSET);
        
        // 设置栈指针
        // sp 为内核态指针
        // sscratch 为用户态指针
        task[i]->thread.sp = (uint64_t)task[i] + PGSIZE;
        task[i]->thread.sscratch = USER_END;
    }
    printk("...task_init done!\n");
}

extern void __switch_to(struct task_struct *prev, struct task_struct *next);

void switch_to(struct task_struct *next) {
    LOG(RED);
    LOG("current->pid = %llu, next->pid = %llu\n", current->pid, next->pid);
    if(current->pid != next->pid) {
        struct task_struct *prev = current;
        current = next;
        printk("\nswitch to [PID = %lld PRIORITY = %lld COUNTER = %lld]\n", current->pid, current->priority, current->counter);
        __switch_to(prev, next);
    }
}

void do_timer() {
    // LOG(RED);
    // 1. 如果当前线程是 idle 线程或当前线程时间片耗尽则直接进行调度
    // 2. 否则对当前线程的运行剩余时间减 1，若剩余时间仍然大于 0 则直接返回，否则进行调度
    if(current->pid == idle->pid || current->counter == 0) {
        schedule();
    }
    else --(current->counter);
}

void schedule() {
    // 1. 调度时选择 counter 最大的线程运行
    // 2. 如果所有线程 counter 都为 0，则令所有线程 counter = priority
    //    设置完后需要重新进行调度
    // 3. 最后通过 switch_to 切换到下一个线程

    // LOG(RED);
    struct task_struct *next = idle;
    for(int i = 1; i < NR_TASKS; ++i) {
        if(task[i]->counter > next->counter){
            next = task[i];
        }
    }

    if(next->counter == 0) {
        printk("\n");
        for(int i = 1; i < NR_TASKS; ++i) {
            task[i]->counter = task[i]->priority;
            printk("SET [PID = %lld PRIORITY = %lld COUNTER = %lld]\n", task[i]->pid, task[i]->priority, task[i]->counter);
        }
        schedule();
    } else {
        switch_to(next);
    }
}