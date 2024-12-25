#ifndef __DEFS_H__
#define __DEFS_H__

#include "stdint.h"

#define csr_read(csr)                       \
({                                          \
    register uint64_t __v;                    \
    asm volatile ("csrr %[__v], " #csr      \
                    : [__v] "=r" (__v));    \
    __v;                                    \
})

#define csr_write(csr, val)                                    \
  ({                                                           \
    uint64_t __v = (uint64_t)(val);                            \
    asm volatile("csrw " #csr ", %0" : : "r"(__v) : "memory"); \
  })

// lab2 add
#define PHY_START 0x0000000080000000
#define PHY_SIZE 128 * 1024 * 1024 // 128 MiB，QEMU 默认内存大小
#define PHY_END (PHY_START + PHY_SIZE)

#define PGSIZE 0x1000 // 4 KiB
#define PGROUNDUP(addr) ((addr + PGSIZE - 1) & (~(PGSIZE - 1)))
#define PGROUNDDOWN(addr) (addr & (~(PGSIZE - 1)))

// lab3 add
#define OPENSBI_SIZE (0x200000)

#define VM_START (0xffffffe000000000)
#define VM_SIZE (VM_END - VM_START)

#define PA2VA_OFFSET (VM_START - PHY_START) //0xffffffdf80000000
#define VM_END (PHY_END + PA2VA_OFFSET)

// lab4 add
#define USER_START (0x0000000000000000) // user space start virtual address
#define USER_END (0x0000004000000000) // user space end virtual address

#define SPP 8
#define SPIE 5
#define SUM 18

// lab5 add
// 每块 vma 都有自己的 flag 来定义权限以及分类（是否匿名）
#define VM_ANON 0x1
#define VM_READ 0x2
#define VM_WRITE 0x4
#define VM_EXEC 0x8

// my add
#define MIN(a, b) ((a) < (b) ? (a) : (b))
#define MAX(a, b) ((a) > (b) ? (a) : (b))

#define VA2PA(x) (((uint64_t)(x) - (uint64_t)PA2VA_OFFSET))
#define PA2VA(x) (((uint64_t)(x) + (uint64_t)PA2VA_OFFSET))
#define PFN2PHYS(x) (((uint64_t)(x) << 12) + PHY_START)
#define PHYS2PFN(x) ((((uint64_t)(x) - PHY_START) >> 12))

#endif
