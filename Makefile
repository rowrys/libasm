NAME = libasm.a
BIN = libasm
ASM = nasm
ASMFLAGS = -f elf64
CC = cc
CFLAGS = -Wall -Wextra -Werror -g
INCLUDES = -I includes/
SRCS_DIR = srcs/
OBJ_DIR = .build/
SOURCES =	$(SRCS_DIR)str/ft_strlen.asm			\
			$(SRCS_DIR)str/ft_strcpy.asm			\
			$(SRCS_DIR)str/ft_strcmp.asm			\
			$(SRCS_DIR)str/ft_strdup.asm			\
			$(SRCS_DIR)io/ft_write.asm				\
			$(SRCS_DIR)io/ft_read.asm				\
			$(SRCS_DIR)stdlib/ft_atoi_base.asm		\
			$(SRCS_DIR)stdlib/ft_bzero.asm			\
			$(SRCS_DIR)lst/ft_list_push_front.asm	\
			$(SRCS_DIR)lst/ft_list_size.asm			\
			$(SRCS_DIR)lst/ft_list_sort.asm			\
			$(SRCS_DIR)lst/ft_list_remove_if.asm	\

SOURCES_TEST =	$(SOURCES)				\
				main.c

OBJS = $(SOURCES:$(SRCS_DIR)%.asm=$(OBJ_DIR)%.o)
OBJS_TEST = $(SOURCES_TEST:$(SRCS_DIR)%.asm=$(OBJ_DIR)%.o)

all: $(NAME)

test: $(BIN)

$(NAME): $(OBJS)
	ar rcs $(NAME) $(OBJS)

$(BIN): $(OBJS_TEST)
	$(CC) $(CFLAGS) $(INCLUDES) $(OBJS_TEST) -o $(BIN)

$(OBJ_DIR)%.o: $(SRCS_DIR)%.asm
	@mkdir -p $(@D)
	$(ASM) $(ASMFLAGS) $< -o $@

gdb: $(NAME)
	gdb $(NAME)

clean:
	rm -rf $(OBJ_DIR)

fclean: clean
	rm -rf $(NAME)
	rm -rf $(BIN)

re: fclean all

.PHONY: all clean fclean re gdb test