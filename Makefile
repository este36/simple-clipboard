NAME = simpleclipboard
CC = gcc
CFLAGS = -Wall -Wextra -std=c11
OBJ_DIR = obj
SRC_DIR = src
SRC = main.c

SRCS = $(addprefix $(SRC_DIR)/, $(SRC))
OBJS = $(addprefix $(OBJ_DIR)/, $(SRC:%.c=%.o))

all : $(NAME)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(NAME): $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o $(NAME) $(LFLAGS)

clean:
	rm -rf $(OBJ_DIR)
