NAME = simpleclipboard
CC = gcc

CFLAGS = -Wall -Wextra -std=c11
POSIX_FLAGS = -D_POSIX_C_SOURCE=200809L

OBJ_DIR = obj
SRC_DIR = src

SRC = main.c \
      mongoose.c

SRCS = $(addprefix $(SRC_DIR)/, $(SRC))
OBJS = $(addprefix $(OBJ_DIR)/, $(SRC:%.c=%.o))

all: $(NAME)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) $(if $(findstring mongoose.c,$<),$(POSIX_FLAGS),) -c $< -o $@

$(NAME): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $(NAME)

clean:
	rm -rf $(OBJ_DIR)

