#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

#define INIT_SIZE 2


/* ******* Buffer functions ******* */

char* initBuffer(size_t size) {
    return malloc(size * sizeof(char));
}

void push(char *buffer, char value, size_t *currLength, size_t *bufferSize) {
    if (*currLength + 1 > *bufferSize) {
        *bufferSize = *bufferSize * 2;
        buffer      = realloc(buffer, *bufferSize * sizeof(char));
    }

    buffer[*currLength] = value;
    *currLength         = *currLength + 1;
}

/* ******* Matrix implementation ******* */

typedef struct matrix
{
    size_t rows;
    size_t cols;
    double *array;
} matrix_t;

matrix_t* create_matrix(size_t rows, size_t cols) {
    matrix_t *matrix = malloc(sizeof(matrix_t) + rows * cols * sizeof(double)); 
    matrix->cols     = cols;
    matrix->rows     = rows;
    return matrix;
}

void destroy_matrix(matrix_t* m) {
    free(m);
}

/* ******* Value processing ******* */ 

double getValue(bool *endOfInput) {
    char c;
    bool stop         = false;
    size_t length     = 0;
    size_t bufferSize = INIT_SIZE;
    char *buffer      = initBuffer(bufferSize);

    while (!stop) {
        c = (char) getchar();
        if (c == ' ' || c == '\n' || c == EOF) {
            *endOfInput = (c == EOF);
            stop = true;
        } else {
            push(buffer, c, &length, &bufferSize);
        }
    }
    double value = atof(buffer);
    free(buffer);
    printf("char at the end of this is %c \n", c);
    return value;
}

int main () {
    bool endOfInput = false;
    while (!endOfInput) {
        double value = getValue(&endOfInput);
        printf("value is %d \n", endOfInput);
        printf("value is %f \n", value);
    }
    return 0;
}