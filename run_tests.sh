#! /bin/bash

FILES=$(ls tests)

for f in $FILES
do
    cat tests/$f | ./dynamic > temp.txt
    echo "Running test for $f"
    ./compare_files.sh temp.txt results/$f
    echo
done

rm temp.txt