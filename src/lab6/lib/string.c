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

int memcmp(const void *str1, const void *str2, uint64_t n) { // 如果相同，返回 0
    const char *s1 = str1, *s2 = str2;
    for (uint64_t i = 0; i < n; ++i) {
        if (s1[i] < s2[i]) {
            return -1;
        } else if (s1[i] > s2[i]) {
            return 1;
        }
    }
    return 0;
}

uint64_t strlen(const char *str) {
    for (uint64_t i = 0; 1; ++i) {
        if (str[i] == '\0') {
            return i;
        }
    }
}
