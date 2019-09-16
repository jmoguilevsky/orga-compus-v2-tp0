#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

#define INIT_SIZE 2

/* ******* Buffer functions ******* */

char *initBuffer(size_t size)
{
    return malloc(size * sizeof(char));
}

void push(char *buffer, char value, size_t *currLength, size_t *bufferSize)
{
    if (*currLength + 1 > *bufferSize)
    {
        *bufferSize = *bufferSize * 2;
        buffer = realloc(buffer, *bufferSize * sizeof(char));
    }

    buffer[*currLength] = value;
    *currLength = *currLength + 1;
}

/* ******* Matrix implementation ******* */

typedef struct matrix
{
    size_t rows;
    size_t cols;
    double *array;
} matrix_t;

matrix_t *create_matrix(size_t rows, size_t cols)
{
    matrix_t *matrix = malloc(sizeof(matrix_t));
    double *array = malloc(sizeof(double) * cols * rows);
    matrix->array = array;
    matrix->cols = cols;
    matrix->rows = rows;
    return matrix;
}

int print_matrix(FILE *fp, matrix_t *m)
{
    int elementCount = m->rows * m->cols;
    for (int i = 0; i < elementCount; i++)
    {
        char *format = (i == elementCount - 1) ? "%f\n" : "%f ";
        int res = fprintf(fp, format, m->array[i]);
        if (res < 0)
        {
            fprintf(stderr, "Error writing to file\n");
            return res;
        }
    }
    return elementCount;
}

matrix_t *matrix_product(matrix_t *matrix1, matrix_t *matrix2)
{
    matrix_t *result = create_matrix(matrix1->rows, matrix2->cols);

    for (int i = 0; i < matrix1->rows; i++)
    {
        for (int j = 0; j < matrix2->cols; j++)
        {
            double acum = 0;
            for (int k = 0; k < matrix1->cols; k++)
            {
                acum = acum + matrix1->array[matrix1->cols * i + k] * matrix2->array[matrix2->cols * k + j];
            }

            result->array[matrix2->cols + j] = acum;
        }
    }

    return result;
}

void destroy_matrix(matrix_t *m)
{
    free(m->array);
    free(m);
}

/* ******* Value processing ******* */

int getValue(double *value_ptr, bool *eol, bool *eof)
{
    char c;
    bool stop = false;
    size_t length = 0;
    size_t bufferSize = INIT_SIZE;
    char *buffer = initBuffer(bufferSize);

    while (!stop)
    {
        c = (char)getchar();
        if (c == ' ' || c == '\n' || c == EOF)
        {
            *eol = (c == '\n');
            *eof = (c == EOF);
            stop = true;
        }
        else
        {
            push(buffer, c, &length, &bufferSize);
        }
    }
    if (length > 0)
    {
        *value_ptr = atof(buffer);
    }
    free(buffer);
    return length;
}

int readMatrix(matrix_t *matrix, int dim, bool *eol, bool *eof)
{
    double value;
    int res;

    for (int i = 0; i < dim * dim; i++)
    {
        res = getValue(&value, eol, eof);
        if (res == 0 && (*eol || *eof))
        {
            fprintf(stderr, "Invalid format, cannot read matrix\n");
            return -1;
        }
        else
        {
            matrix->array[i] = value;
        }
    }

    return 0;
}

enum LineEnding
{
    EndOfLine,
    EndOfFile,
    Error
};

enum LineEnding processLine()
{
    double value;
    int res;
    size_t dim;

    bool eol = false;
    bool eof = false;

    res = getValue(&value, &eol, &eof);

    if (eof)
    {
        return EndOfFile;
    }

    if (eol)
    {
        return EndOfLine;
    }

    if (res == 0)
    {
        fprintf(stderr, "Invalid format, cannot read matrices\n");
        return Error;
    }

    dim = (size_t)value;

    matrix_t *matrix1 = create_matrix(dim, dim);

    readMatrix(matrix1, dim, &eol, &eof);
    print_matrix(stdout, matrix1);

    matrix_t *matrix2 = create_matrix(dim, dim);

    readMatrix(matrix2, dim, &eol, &eof);

    matrix_t *result = matrix_product(matrix1, matrix2);
    print_matrix(stdout, result);

    free(matrix1);
    free(matrix2);

    return EndOfLine;
}

int main()
{
    enum LineEnding result;

    do
    {
        result = processLine();
    } while (result == EndOfLine);

    if (result == Error)
    {
        return -1;
    }

    return 0;
}