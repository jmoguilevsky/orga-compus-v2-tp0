#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <getopt.h>


#define INIT_SIZE 2

/* ******* Buffer functions ******* */

char *init_buffer(size_t size)
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

typedef struct parsed_args {
    char* _input_filename;	// privado
    char* _output_filename;	// privado
} parsed_args_t;

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

    for (int i = 0; i < matrix1->rows; i++)
    {
        for (int j = 0; j < matrix2->cols; j++)
        {
            double acum = 0;
            for (int k = 0; k < matrix1->cols; k++)
            {
                acum = acum + matrix1->array[matrix1->cols * i + k] * matrix2->array[matrix2->cols * k + j];
            }
            result->array[result->cols * i + j] = acum;
        }
    }

    // print_matrix(stdout, result);

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

int read_matrix(matrix_t *matrix, int dim, bool *eol, bool *eof)
{
    double value;
    int res;

    for (int i = 0; i < dim * dim; i++)
    {
        res = get_value(&value, eol, eof);
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

    read_matrix(matrix1, dim, &eol, &eof);
    // print_matrix(stdout, matrix1);

    matrix_t *matrix2 = create_matrix(dim, dim);

    read_matrix(matrix2, dim, &eol, &eof);
    // print_matrix(stdout, matrix2);

    matrix_t *result = matrix_multiply(matrix1, matrix2);

    print_matrix(stdout, result);

    free(matrix1);
    free(matrix2);
    free(result);

    return EndOfLine;
}

static void print_usage(const char* src) {
    printf("%s\n\t%s%s\n\t%s%s\n\t%s%s\n", "Usage:",
           src, " -h",
           src, " -V",
           src, " < in_file > out_file");
}

static void print_options(const char* src) {
    printf("%s\n%s\n%s\n%s\n%s%s\t%s\n%s%s%s\n",
            "Options:",
           "\t-V, --version\tVersión del programa.",
           "\t-h, --help\tImprime ayuda.",
           "Examples:",
           "\t", src, "tp0 < in.txt > out.txt",
           "\tcat in.txt ", src, " | tp0 > out.txt");
}

static void print_help(const char* src) {
    print_usage(src);
    print_options(src);
}

static void print_version(const char* src) {
    printf("%s: Version 1.0.0\n", src);
}

int argsHandler_parse_arguments(const int argc, char* const argv[]) {
    int arg;
    int option_index = 0;
    const char* short_opt = "hV";
    static struct option long_options[] = {
            {"help",    no_argument,       0, 'h'},
            {"version", no_argument,       0, 'V'},
            {0,         0,                 0,  0 }
    };

    while ((arg = getopt_long(argc, argv, short_opt, long_options, &option_index)) != -1) {
        switch (arg) {
            case 'h':
                print_help(argv[0]);
                exit(EXIT_SUCCESS);
            case 'V':
                print_version(argv[0]);
                exit(EXIT_SUCCESS);
            case '?':
                exit(EXIT_FAILURE);
                break;
            default:
                break;
        }
    }

    // extern int optind
    if (optind < argc) {
        fprintf(stderr, "Opciones no reconocidas: ");
        while (optind < argc) {
            fprintf(stderr, "%s ", argv[optind++]);
        }
        fprintf(stderr, "\n");
        exit(EXIT_FAILURE);
    }

    return EXIT_SUCCESS;
}

int main(int argc, char* const argv[])
{
    argsHandler_parse_arguments(argc, argv);

    enum LineEnding result;

    do
    {
        result = process_line();
    } while (result == EndOfLine);

    if (result == Error)
    {
        return -1;
    }

    return 0;
}