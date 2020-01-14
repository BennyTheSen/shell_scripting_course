#!/bin/bash

# script that adds users to the same Linux system as the script is executed on

# enforce execution as root
if [[ "${UID}" -ne "0" ]]
then
    echo "please run script with superuser"
    exit 1
fi

# usage statement if not given args
if [[ "${#}" -eq 0 ]]
then
    echo "Usage: ${0} USERNAME [COMMENTS]..."
    exit 1
fi

# first arg = username
USERNAME=${1}

# all following args are comments
shift 1
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
useradd -c "${COMMENTS}" -m ${USERNAME}
if [[ "${?}" -ne "0" ]]
then
    echo "Something went wrong."
    exit 1
fi

# generate password and set it
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48)
echo ${USERNAME}:${PASSWORD} | chpasswd 
if [[ "${?}" -ne "0" ]]
then
    echo "Something went wrong."
    exit 1
fi

# force password change on first login
passwd -e ${USERNAME}

# get hostname
HOSTNAME=$(hostname)

# display username, password, host
echo "Username: ${USERNAME}"
echo "Password: ${PASSWORD}"
echo "Hostname: ${HOSTNAME}"