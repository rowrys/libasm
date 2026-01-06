NAME = libasm.a
BIN = libasm
ASM = nasm
ASMFLAGS = -f elf64
CC = cc
CFLAGS = -no-pie -Wall -Wextra -Werror
SRCS_DIR = srcs/
OBJ_DIR = .build/
SOURCES =	$(SRCS_DIR)ft_strlen.asm	\
			$(SRCS_DIR)ft_strcpy.asm	\
			$(SRCS_DIR)ft_strcmp.asm	\
			$(SRCS_DIR)ft_strdup.asm	\
			$(SRCS_DIR)ft_write.asm		\
			$(SRCS_DIR)ft_read.asm		\


SOURCES_TEST =	$(SOURCES)				\
				$(SRCS_DIR)main.asm

OBJS = $(SOURCES:$(SRCS_DIR)%.asm=$(OBJ_DIR)%.o)
OBJS_TEST = $(SOURCES_TEST:$(SRCS_DIR)%.asm=$(OBJ_DIR)%.o)

all: $(NAME)

test: $(BIN)

$(NAME): make_dir $(OBJS)
	ar rcs $(NAME) $(OBJS)

$(BIN): make_dir $(OBJS_TEST)
	$(CC) $(CFLAGS) $(OBJS_TEST) -o $(BIN)

make_dir:
	@mkdir -p .build/

$(OBJ_DIR)%.o: $(SRCS_DIR)%.asm
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