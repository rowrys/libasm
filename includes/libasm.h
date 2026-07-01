#ifndef LIBASM_H
# define LIBASM_H

# include <unistd.h>

ssize_t	ft_read(int fd, char *buffer, size_t size);
int		ft_strcmp(char const *s1, char const *s2);
char	*ft_strcpy(char *dst, char const *src);
char	*ft_strdup(char const *str);
size_t	ft_strlen(char const *str);
ssize_t	ft_write(int fd, char const *str, size_t size);
void	ft_bzero(void* ptr, size_t n);
int		ft_atoi_base(char* str, char* base);

#endif
