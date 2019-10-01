#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <getopt.h>

#define VERSION "1.0.0"
#define INIT_SIZE 2

/* ******* Buffer functions ******* */

char *init_buffer(size_t size)
{
    return calloc(size, size * sizeof(char));
}

char *push(char *buffer, char value, size_t *currLength, size_t *bufferSize)
{
    *currLength = *currLength + 1;

    if (*currLength >= *bufferSize)
    {
        char *newBuff;
        *bufferSize = *bufferSize * 2;
        newBuff = realloc(buffer, *bufferSize * sizeof(char));
        newBuff[*currLength - 1] = value;
        return newBuff;
    }
    buffer[*currLength - 1] = value;
    return buffer;
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

    int i = 0;
    for (i; i < elementCount; i++)
    {
        char *format = (i == elementCount - 1) ? "%.10g\n" : "%.10g ";
        int res = fprintf(fp, format, m->array[i]);
        if (res < 0)
        {
            fprintf(stderr, "Error writing to file\n");
            return res;
        }
    }
    return elementCount;
}

matrix_t *matrix_multiply(matrix_t *matrix1, matrix_t *matrix2)
{
    matrix_t *result = create_matrix(matrix1->rows, matrix2->cols);

    int i = 0;
    for (i; i < matrix1->rows; i++)
    {
        int j = 0;
        for (j; j < matrix2->cols; j++)
        {
            double acum = 0;
            int k = 0;
            for (k; k < matrix1->cols; k++)
            {
                acum = acum + matrix1->array[matrix1->cols * i + k] * matrix2->array[matrix2->cols * k + j];
            }
            result->array[result->cols * i + j] = acum;
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

int get_value(double *value_ptr, bool *eol, bool *eof)
{
    char c;
    bool stop = false;
    size_t length = 0;
    size_t bufferSize = INIT_SIZE;
    char *buffer = init_buffer(bufferSize);

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
            char *new_buffer = push(buffer, c, &length, &bufferSize);
            buffer = new_buffer;
        }
    }
    if (length > 0)
    {
        buffer[length] = 0;
        int res = sscanf(buffer, "%lG", value_ptr);

        // Si no puede interpretar un double, da error.
        if (res == 0) {
            return -1;
        }
    }
    free(buffer);
    return length;
}

int read_matrix(matrix_t *matrix, int dim, bool *eol, bool *eof)
{
    int res;
    double value;

    int i = 0;
    for (i; i < dim * dim; i++)
    {
        res = get_value(&value, eol, eof);

        if (res < 0 || (res == 0 && (*eol || *eof)))
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

enum LineEnding process_line()
{
    double value;
    int res;
    size_t dim;

    bool eol = false;
    bool eof = false;

    res = get_value(&value, &eol, &eof);

    if (eof)
    {
        fprintf(stderr, "Invalid format, cannot read matrix\n");
        return Error;
    }

    if (eol)
    {
        fprintf(stderr, "Invalid format, cannot read matrix\n");
        return Error;
    }

    if (res <= 0)
    {
        fprintf(stderr, "Invalid format, cannot read matrix\n");
        return Error;
    }

    dim = (size_t)value;
    int response;

    matrix_t *matrix1 = create_matrix(dim, dim);

    response = read_matrix(matrix1, dim, &eol, &eof);

    if (response == -1)
    {
        destroy_matrix(matrix1);
        return Error;
    }

    matrix_t *matrix2 = create_matrix(dim, dim);
    response = read_matrix(matrix2, dim, &eol, &eof);

    if (response == -1)
    {
        destroy_matrix(matrix1);
        destroy_matrix(matrix2);
        return Error;
    }

    if (!eol && !eof)
    {
        destroy_matrix(matrix1);
        destroy_matrix(matrix2);
        fprintf(stderr, "Invalid format, cannot read matrix\n");
        return Error;
    }

    matrix_t *result = matrix_multiply(matrix1, matrix2);

    printf("%zu ", dim);
    print_matrix(stdout, result);

    destroy_matrix(matrix1);
    destroy_matrix(matrix2);
    destroy_matrix(result);

    return EndOfLine;
}

static void print_usage(const char *src)
{
    printf("%s\n\t%s%s\n\t%s%s\n\t%s%s\n", "Usage:",
           src, " -h",
           src, " -V",
           src, " < in_file > out_file");
}

static void print_options(const char *src)
{
    printf("%s\n%s\n%s\n%s\n%s%s\t%s\n%s%s%s\n",
           "Options:",
           "\t-V, --version\tProgram version.",
           "\t-h, --help\tPrint help.",
           "Examples:",
           "\t", src, "tp0 < in.txt > out.txt",
           "\tcat in.txt ", src, " | tp0 > out.txt");
}

static void print_help(const char *src)
{
    print_usage(src);
    print_options(src);
}

static void print_version()
{
    printf("Version %s\n", VERSION);
}

int argsHandler_parse_arguments(const int argc, char *const argv[])
{
    int arg;
    int option_index = 0;
    const char *short_opt = "hV";
    static struct option long_options[] = {
        {"help", no_argument, 0, 'h'},
        {"version", no_argument, 0, 'V'},
        {0, 0, 0, 0}};

    while ((arg = getopt_long(argc, argv, short_opt, long_options, &option_index)) != -1)
    {
        switch (arg)
        {
        case 'h':
            print_help(argv[0]);
            exit(EXIT_SUCCESS);
        case 'V':
            print_version();
            exit(EXIT_SUCCESS);
        case '?':
            exit(EXIT_FAILURE);
            break;
        default:
            break;
        }
    }

    // extern int optind
    if (optind < argc)
    {
        fprintf(stderr, "Unrecognized options: ");
        while (optind < argc)
        {
            fprintf(stderr, "%s ", argv[optind++]);
        }
        fprintf(stderr, "\n");
        exit(EXIT_FAILURE);
    }

    return EXIT_SUCCESS;
}

int main(int argc, char *const argv[])
{
    argsHandler_parse_arguments(argc, argv);

    enum LineEnding result;

    do
    {
        result = process_line();
    } while (result == EndOfLine && result != Error);

    if (result == Error)
    {
        return -1;
    }

    return 0;
}
