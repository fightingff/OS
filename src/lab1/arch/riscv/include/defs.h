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

#endif
