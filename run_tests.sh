FILES=$(ls tests)

for f in $FILES
do
    cat tests/$f | ./dynamic > temp.txt 2>error_temp.txt
    echo "Running test for $f"
    ./compare_files.sh temp.txt results/$f
    ./compare_files.sh error_temp.txt results/error_$f
    echo
done


echo "Running test for help menu"
./dynamic -h > temp.txt
./compare_files.sh temp.txt menu_tests/help.txt

./dynamic --help > temp.txt
./compare_files.sh temp.txt menu_tests/help.txt

echo "Running test for version menu"
./dynamic -V > temp.txt
./compare_files.sh temp.txt menu_tests/version.txt

./dynamic --version > temp.txt
./compare_files.sh temp.txt menu_tests/version.txt


rm temp.txt
rm error_temp.txt
