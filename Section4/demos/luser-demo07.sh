#!/bin/bash

# demonstrate use of shift and while loops


# display first three paramters
echo "Parameter 1: ${1}"
echo "Parameter 2: ${2}"
echo "Parameter 3: ${3}"
echo 

# loop through all positional parameters
while [[ "${#}" -gt 0 ]]
do
    echo "Number of Parameters: ${#}"
    echo "Parameter 1: ${1}"
    echo "Parameter 2: ${2}"
    echo "Parameter 3: ${3}"
    echo
    shift 2
done

