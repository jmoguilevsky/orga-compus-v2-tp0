CC=gcc
CFLAGS= -std=c99 -Wall -Werror -pedantic -pedantic-errors
.PHONY: all

all: dynamic

clean:
	rm -rf *.o

dynamic: dynamic.o
	$(CC) -o dynamic dynamic.o