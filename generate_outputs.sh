#! /bin/bash

FILES=$(ls tests)

rm -rf results
mkdir results

for f in $FILES
do
    cat tests/$f | ./dynamic >> results/$f 2>results/error_$f
done

./dynamic -h > results/help_menu_1.txt
./dynamic --help > results/help_menu_2.txt
./dynamic -V > results/version_1.txt
./dynamic --version > results/version_2.txt