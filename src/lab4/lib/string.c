#include "string.h"
#include "stdint.h"

void *memset(void *dest, uint8_t c, uint64_t n) {
    char *d = (char *)dest;
    for (uint64_t i = 0; i < n; ++i) {
        d[i] = c;
    }
    return dest;
}

void *memcpy(void *dest, void *src, uint64_t n) {
    char *d = (char *)dest;
    char *s = (char *)src;
    for (uint64_t i = 0; i < n; ++i) {
        d[i] = s[i];
    }
    return dest;
}