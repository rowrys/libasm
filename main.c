
#include "libasm.h"

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>

void test_strlen(void)
{
    char *str = "Hello World";

    printf("=== FT_STRLEN ===\n");
    printf("strlen    : %zu\n", strlen(str));
    printf("ft_strlen : %zu\n\n", ft_strlen(str));
}

void test_strcmp(void)
{
    printf("=== FT_STRCMP ===\n");

    printf("strcmp(\"abc\", \"abc\")    = %d\n",
        strcmp("abc", "abc"));
    printf("ft_strcmp(\"abc\", \"abc\") = %d\n\n",
        ft_strcmp("abc", "abc"));

    printf("strcmp(\"abc\", \"abd\")    = %d\n",
        strcmp("abc", "abd"));
    printf("ft_strcmp(\"abc\", \"abd\") = %d\n\n",
        ft_strcmp("abc", "abd"));

    printf("strcmp(\"abd\", \"abc\")    = %d\n",
        strcmp("abd", "abc"));
    printf("ft_strcmp(\"abd\", \"abc\") = %d\n\n",
        ft_strcmp("abd", "abc"));
}

void test_strcpy(void)
{
    char dst1[100];
    char dst2[100];

    strcpy(dst1, "Hello");
    ft_strcpy(dst2, "Hello");

    printf("=== FT_STRCPY ===\n");
    printf("strcpy    : %s\n", dst1);
    printf("ft_strcpy : %s\n\n", dst2);
}

void test_strdup(void)
{
    char *s1;
    char *s2;

    s1 = strdup("Duplicate me");
    s2 = ft_strdup("Duplicate me");

    printf("=== FT_STRDUP ===\n");
    printf("strdup    : %s\n", s1);
    printf("ft_strdup : %s\n", s2);
    printf("same addr ? %s\n\n", (s1 == s2) ? "YES" : "NO");

    free(s1);
    free(s2);
}

void test_write(void)
{
    printf("=== FT_WRITE ===\n");

    write(1, "write    : Hello\n", 17);
    ft_write(1, "ft_write : Hello\n", 17);

    printf("\n");
}

void test_read(void)
{
    int     fd1;
    int     fd2;
    char    buf1[100];
    char    buf2[100];
    ssize_t r1;
    ssize_t r2;

    fd1 = open("main.c", O_RDONLY);
    fd2 = open("main.c", O_RDONLY);

    if (fd1 < 0 || fd2 < 0)
    {
        perror("open");
        return;
    }

    r1 = read(fd1, buf1, sizeof(buf1) - 1);
    r2 = ft_read(fd2, buf2, sizeof(buf2) - 1);

    if (r1 >= 0)
        buf1[r1] = '\0';
    if (r2 >= 0)
        buf2[r2] = '\0';

    printf("=== FT_READ ===\n");
    printf("read bytes    : %zd\n", r1);
    printf("ft_read bytes : %zd\n\n", r2);

    printf("read result:\n%s\n\n", buf1);
    printf("ft_read result:\n%s\n\n", buf2);

    close(fd1);
    close(fd2);
}

int main(void)
{
    test_strlen();
    test_strcmp();
    test_strcpy();
    test_strdup();
    test_write();
    test_read();

    return (0);
}