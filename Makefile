CC=gcc
CFLAGS= -Wall
.PHONY: all

all: dynamic

clean:
	rm -rf *.o

dynamic: dynamic.o matrix_multiply.o mymalloc.o
	$(CC) -o dynamic dynamic.o matrix_multiply.o mymalloc.o
