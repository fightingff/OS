#ifndef __STRING_H__
#define __STRING_H__

#include "stdint.h"

void *memset(void *, uint8_t, uint64_t);
void *memcpy(void *, const void *, uint64_t);
int memcmp(const void *str1, const void *str2, uint64_t n);
uint64_t strlen(const char *str);

#endif