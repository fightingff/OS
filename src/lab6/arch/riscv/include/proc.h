#ifndef __PROC_H__
#define __PROC_H__

#include "stdint.h"
#include "trap.h"

#define NR_TASKS (1 + 512)   // 用于控制最大线程数量（idle 线程 + 512 线程）

#define TASK_RUNNING 0      // 为了简化实验，所有的线程都只有一种状态

#define PRIORITY_MIN 1
#define PRIORITY_MAX 10

// lab5 vma 的数据结构
struct vm_area_struct {
    struct mm_struct *vm_mm;    // 所属的 mm_struct（即指向表头）
    uint64_t vm_start;          // VMA 对应的用户态虚拟地址的开始
    uint64_t vm_end;            // VMA 对应的用户态虚拟地址的结束（我规定：不包含）
    // [vm_start, vm_end)
    struct vm_area_struct *vm_next, *vm_prev;   // 链表指针
    uint64_t vm_flags;          // VMA 对应的 flags
    // struct file *vm_file;    // 对应的文件（目前还没实现，而且我们只有一个 uapp 所以暂不需要）
    uint64_t vm_pgoff;          // 如果对应了一个文件，那么这块 VMA 起始地址对应的文件内容相对文件起始位置的偏移量
    uint64_t vm_filesz;         // 对应的文件内容的长度
};

// memory manager
struct mm_struct {
    struct vm_area_struct *mmap; // 表头
};

// lab4 的 线程状态段数据结构
struct thread_struct {
    uint64_t ra;
    uint64_t sp;                     
    uint64_t s[12];
    uint64_t sepc, sstatus, sscratch;  // lab4 独有
};

struct task_struct {
    uint64_t state;     // 线程状态
    uint64_t counter;   // 运行剩余时间
    uint64_t priority;  // 运行优先级 1 最低 10 最高
    uint64_t pid;       // 线程 id

    struct thread_struct thread;
    uint64_t *pgd;  // 用户态页表, lab4 独有

    struct mm_struct mm; // lab5 add: memory manager, 用于实现 demand paging
    
    struct files_struct *files; // lab6 add: 维护该进程打开的文件列表
};

/* 传入虚拟地址，查找 vma
* @mm       : current thread's mm_struct
* @addr     : the va to look up
*
* @return   : the VMA if found or NULL if not found
*/
struct vm_area_struct *find_vma(struct mm_struct *mm, uint64_t addr);

/* do memory map, 其实就是向链表加入 vma
* @mm       : current thread's mm_struct
* @addr     : the va to map
* @len      : memory size to map （我规定 len 的 memory 大小包括了页对齐，并且是整页）
* @vm_pgoff : phdr->p_offset（之后处理缺页的时候，要把 p_offset 对应页的页首对齐 addr）
* @vm_filesz: phdr->p_filesz
* @flags    : flags for the new VMA（我规定他就是 phdr->p_flags）
*
* @return   : start va
*/
uint64_t do_mmap(struct mm_struct *mm, uint64_t addr, uint64_t len, uint64_t vm_pgoff, uint64_t vm_filesz, uint64_t flags);

// 根据 vma, 映射包含 bad_addr 一页 到 用户线程的页表 pgd
// 传入的 pgd 是物理地址的
void do_map_one_page(uint64_t *pgd, struct vm_area_struct *vma, uint64_t bad_addr);

uint64_t do_fork(struct pt_regs *regs);

/* 线程初始化，创建 NR_TASKS 个线程 */
void task_init();

/* 在时钟中断处理中被调用，用于判断是否需要进行调度 */
void do_timer();

/* 调度程序，选择出下一个运行的线程 */
void schedule();

/* 线程切换入口函数 */
void switch_to(struct task_struct *next);

/* dummy funciton: 一个循环程序，循环输出自己的 pid 以及一个自增的局部变量 */
void dummy();

#endif
