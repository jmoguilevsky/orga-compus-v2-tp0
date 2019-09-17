#! /bin/bash

FILES=$(ls tests)

for f in $FILES
do
    cat tests/$f | ./dynamic > temp.txt 2>error_temp.txt
    echo "Running test for $f"
    ./compare_files.sh temp.txt results/$f
    ./compare_files.sh error_temp.txt results/error_$f
    echo
done

rm temp.txt
rm error_temp.txt