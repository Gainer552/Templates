#!/bin/bash

#Description
echo "This is a template for creating quality Bash scripts."
echo

#Strings
echo "Enter a string here."
echo

#Integers
declare -i x=0
echo

#Floats
num=10.50
echo

#Variable.
[IDENTIFIER]=[VALUE]

#Boolean.
true/false
#Use boolean in a conditional statement.
[identifier]="true"

if [[ "$identifier" == "true" ]]; then
    echo "The boolean is true."
else
    echo "The boolean is false."
fi

#If Statement
#Define a variable.
[NUMBER1]=[5]
[NUMBER2]=3
#Check if the number is greater than 5.
if [ "$[NUMBER1]" -gt $[NUMBER2] ]; then
  echo "The value is greater than $NUMBER2"
fi

#If/Else Statement
#Initialize a variable.
[NUMBER]=8

#Start the comparison.
if [ "$[NUMBER]" -gt 10 ]; then
  echo "Number is greater than 10!"
else
  echo "Number is 10 or less."
fi

#For Loop
# This script iterates from 1 to 5 and prints the current number.
for i in 1 2 3 4 5; do
  echo "Number: $i"
done

#While Loop
#Initialize the counter variable.
i=1
#Loop while 'i' is less than or equal to 5.
while [ $i -le 5 ]
do
#Print the current value of the counter.
  echo "Count is $i."
#Increment the counter by 1.
  ((i++))
done
echo "Loop finished"

#Indexed Array
#Declare an array.
[IDENTIFIER]=("value1" "value2" "value3")
#Access a specific element.
echo "[NAME]: ${[ARRAY][INDEX]}"
#Access every element.
echo "[NAME]: ${[ARRAY][@]}"
#Loop through array.
echo "Looping:"
for [ELEMENT] in "${[ARRAY][@]}"; do
    echo "- $[ELEMENT]"
done

#Associative Array
#Declare an associative array using the -A flag.
declare -A [IDENTIFIER]
#Add key-value pairs.
[IDENTIFIER][name]="John Doe"
[IDENTIFIER][email]="john@example.com"
[IDENTIFIER][age]=30
#Access and print a specific value using its key.
echo "Name: ${[IDENTIFIER][name]}"
echo "Email: ${[IDENTIFIER][email]}"
# Print all keys.
echo "Available information keys: ${![IDENTIFIER][@]}"
# Print all values.
echo "User details values: ${[IDENTIFIER][@]}"
# Iterate over all key-value pairs.
echo "Looping through all details:"
for key in "${![IDENTIFIER][@]}"; do
    echo "$key => ${[IDENTIFIER][$key]}"
done

#Functions
function_name () {
	echo "Commands and data types go here."
	declare -i x=0
	num=10.50
	name=true
	array=(value1 value2 value3)
}
function_name

#Case Statement
echo -n "Enter a letter (a, b, or c): "
read letter_input

case $letter_input in
    a)
        echo "You entered the first letter of the alphabet."
        ;;
    b)
        echo "You entered the second letter."
        ;;
    c)
        echo "You entered the third letter."
        ;;
    *)
        echo "You entered something else entirely."
        ;;
esac

#Simulated objects.
declare -A object

object[string]="Strings go here."
object[number]=30
object=(string number)

echo "string: ${object[string]}"
echo "number: ${object[number]}"
