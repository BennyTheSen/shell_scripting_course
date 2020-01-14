#!/bin/bash

# script generates a random password for each user specified in command line

# display what user typed
echo "you typed this command: ${0}"

# display path and filename
echo "you used $(dirname ${0}) as the path to the $(basename ${0}) script"

# tell how many arguments where passed in 
NUMBER_ARGS="${#}"
echo "you supplied ${NUMBER_ARGS} arguments"

# check if user got supplied
if [[ "$NUMBER_ARGS" -lt 1 ]]
then 
    echo "Usage: ${0} USERNAME [USERNAME]..."
    exit 1
fi

# generate and display password for each user
for USER_NAME in "${@}"
do
    PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48)
    echo "${USER_NAME}:${PASSWORD}"
done
