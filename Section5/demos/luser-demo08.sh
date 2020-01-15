#!/bin/bash

# script demonstrates I/O redirection

# redirect stdout
FILE="/tmp/data.txt"
head -n 1 /etc/passwd > ${FILE}

# redirect stdin
read LINE < ${FILE}
echo "Line contains: ${LINE}"

#redirect stdout to a file, overwriting
head -n3 /etc/passwd > ${FILE}
echo
echo "Contents of File ${FILE}:"

# redirect stdout to file appending
echo "${RANDOM} ${RANDOM}" >> ${FILE}
echo "${RANDOM} ${RANDOM}" >> ${FILE}

#redirect stderr
ERR_FILE="/tmp/data.err"
head -n3 /etc/passwd /fakefile 2> ${ERR_FILE}

#redirect stderr and stdout to a file
head -n3 /etc/passwd /fakefile &> ${FILE}
cat ${FILE}

# redirect stderr and stdout with pipe
echo 
head -n3 /etc/passwd /fakefile |& cat -n

# send output to stderr
echo "This is stderr" >&2

#discard stdout
echo
echo "discard stdout"
head -n3 /etc/passwd /fakefile > /dev/null

#discard stderr
echo
echo "discard stderr"
head -n3 /etc/passwd /fakefile 2> /dev/null

#discard both
echo
echo "discard both"
head -n3 /etc/passwd /fakefile &> /dev/null

# clean up
rm ${FILE} ${ERR_FILE} &> /dev/null
