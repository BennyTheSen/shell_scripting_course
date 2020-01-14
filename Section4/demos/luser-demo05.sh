#!/bin/bash

# script generates list of random passwords

# random number as a password
PASSWORD="$RANDOM"
echo "${PASSWORD}"

# Three random numbers
PASSWORD="${RANDOM}${RANDOM}${RANDOM}"
echo "${PASSWORD}"

# date/time as password
PASSWORD=$(date +%s)
echo "${PASSWORD}"

# date/time + nanoseconds as password
PASSWORD=$(date +%s%N)
echo "${PASSWORD}"

# use date as sha checksum as password
PASSWORD=$(date +%s%N | sha256sum | head -c32)
echo "${PASSWORD}"

# even better password
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48)
echo "${PASSWORD}"

# append special character to password
SPECIAL_CHAR=$(echo '!@#$%&^*+-_=?' | fold -w1 | shuf | head -c1)
echo "${PASSWORD}${SPECIAL_CHAR}"