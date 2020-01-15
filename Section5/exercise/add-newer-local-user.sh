#!/bin/bash

# The goal of this exercise is to create a shell script that adds users to the same Linux system as the
# script is executed on. Additionally this script will conform to Linux program standard conventions.

# enforce root execution 
if [[ "${UID}" -ne "0" ]]
then
    echo "please run script with superuser" >&2
    exit 1
fi

# usage statement if not given args
if [[ "${#}" -eq 0 ]]
then
    echo "Usage: ${0} USERNAME [COMMENTS]..." >&2
    exit 1
fi

# first arg = username
USERNAME=${1}

# all following args are comments
shift 1 &> /dev/null
for COMMENT in "${@}"
do 
    if [[ "${COMMENTS}" = ""  ]]    
    then
        COMMENTS="${COMMENT}"
    else
        COMMENTS="${COMMENTS}, ${COMMENT}"
    fi
done

# add user and inform if account creation not possible
useradd -c "${COMMENTS}" -m ${USERNAME} &> /dev/null
if [[ "${?}" -ne "0" ]]
then
    echo "Something went wrong." >&2
    exit 1
fi

# generate password and set it
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48) &> /dev/null
echo ${USERNAME}:${PASSWORD} | chpasswd &> /dev/null
if [[ "${?}" -ne "0" ]]
then
    echo "Something went wrong." >&2
    exit 1
fi

# force password change on first login
passwd -e ${USERNAME} &> /dev/null

# get hostname
HOSTNAME=$(hostname)

# display username, password, host
echo "Username: ${USERNAME}"
echo "Password: ${PASSWORD}"
echo "Hostname: ${HOSTNAME}"