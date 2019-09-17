# Opciones para el compilador C/C++ para tratamiento de errores y warnings.
CFLAGS = -std=c99 -Wall -Werror -pedantic -pedantic-errors

# Para valgrind o debug
#CFLAGS += -ggdb -fno-inline -g3

.PHONY: all
SRC := .
OBJ := obj

SOURCES := $(wildcard $(SRC)/*.c)
OBJECTS := $(patsubst $(SRC)/%.c, $(OBJ)/%.o, $(SOURCES))

$(OBJ)/%.o: $(SRC)/%.c | $(OBJ)
	$(CC) -I$(SRC) -c $< -o $@ $(CFLAGS)

all: dynamic

dynamic: $(OBJECTS) 
	$(CC) $(OBJ)/dynamic.o -o dynamic

clean:
	$(RM) -f $(OBJECTS) dynamic

$(OBJ):
	mkdir -p $(OBJ)