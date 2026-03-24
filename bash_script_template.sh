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

#Booleans
name=true
echo

#Arrays
array=(value1 value2 value3)
echo

#Functions
function_name () {
	echo "Commands and data types go here."
	declare -i x=0
	num=10.50
	name=true
	array=(value1 value2 value3)
}
function_name

#Simulated objects.
declare -A object

object[string]="Strings go here."
object[number]=30
object=(string number)

echo "string: ${object[string]}"
echo "number: ${object[number]}"