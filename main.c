#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct matrix
{
    size_t rows;
    size_t cols;
    double *array;
} matrix_t;

bool getChar(char *c)
{
    *c = fgetc(stdin);

    if (*c == EOF)
    {
        fprintf(stderr, "es eof\n");
        return false;
    }
    if (*c == '\n')
    {
        fprintf(stderr, "es \\n\n");
        return false;
    }

    return true;
}

int processArguments(char const *arg)
{
    if (strcmp(arg, "-h") == 0)
    {
        printf("Usage:\n\ttp0 -h\n\ttp0 -V\n\ttp0 < in_file > out_file\nOptions:\n\t-V, --version Print version and quit.\n\t-h, --help Print this information and quit.\nExamples:\n\ttp0 < in.txt > out.txt\n\tcat in.txt | tp0 > out.txt");
        return 0;
    }

    if (strcmp(arg, "-V") == 0)
    {
        printf("Version 1.0.0");
        return 0;
    }

    return 1;
}

int getFirstNumber(char firstChar, int *out)
{
    char c;

    int i = 1;

    char currentNumber[1024];

    currentNumber[0] = firstChar;

    while (getChar(&c))
    {
        if (c == ' ')
        {
            break;
        }

        currentNumber[i] = c;
        i++;
    }

    currentNumber[i] = '\0';

    *out = atoi(currentNumber);

    fprintf(stderr, "currentNumber is '%s'\n", currentNumber);
    fprintf(stderr, "out is %d\n", *out);

    return i;
}

// int getFirstNumber(char firstChar, double *out)
// {
//     int c;

//     int i = 1;

//     char *currentNumber;

//     while (!getChar(stdin, &c))
//     {

//         i++;
//     }

//     *out = atof(currentNumber);

//     return i;
// }

int processLine()
{

    char c;
    int N;
    int firstNumber;
    // double *firstMatrix;
    // double *secondMatrix;

    int i = 0;

    fprintf(stderr, "hola\n");

    while (!feof(stdin))
    {

        if (!getChar(&c))
        {
            break;
        }
        fprintf(stderr, "c: %c\n", c);

        i += getFirstNumber(c, &N);

        if (!getChar(&c))
        {
            break;
        }

        fprintf(stderr, "i: %d\n", i);
        i += getFirstNumber(c, &firstNumber);
    }

    fprintf(stderr, "N %d", N);
    fprintf(stderr, "firstNumber %d", firstNumber);

    return 0;
}

int main(int argc, char const *argv[])
{

    if (argc == 2)
    {
        return processArguments(argv[1]);
    }

    processLine();
    return 0;
}
