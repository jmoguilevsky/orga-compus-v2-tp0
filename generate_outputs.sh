#! /bin/bash

FILES=$(ls tests)

rm -rf results
mkdir results

for f in $FILES
do
    cat tests/$f | ./output.c > results/$f
done

./output.c -h > results/help_menu_1.txt
./output.c --help > results/help_menu_2.txt
./output.c -V > results/version_1.txt
./output.c --version > results/version_2.txt