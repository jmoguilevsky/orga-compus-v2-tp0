#! /bin/bash

FILES=$(ls tests)

rm -rf success_results
mkdir success_results

for f in $FILES
do
    cat success_tests/$f | ./output.c > success_results/$f
done