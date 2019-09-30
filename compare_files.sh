result=$(diff -y -W 72 $1 $2)

if [ $? -eq 0 ]
then
        echo "Test successful"
else
        echo "The files are different"
fi