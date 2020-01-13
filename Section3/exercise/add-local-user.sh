#!/bin/bash

# this script creates a new user and prints ouuuuuuuuuuuuuttttttttttt the information 

# check if run as root else exit 1
if [[ "${UID}" -ne "0" ]]
then
    echo "please run script with superuser"
    exit 1
fi

# enter username, realname and password
read -p 'Enter username: ' USER_NAME
read -p 'Enter your name: ' COMMENT
read -p 'Enter initial password: ' PASSWORD

# create user
useradd -c "${COMMENT}" -m ${USER_NAME}
if [[ "${?}" -ne "0" ]]
then
    echo "Something went wrong."
    exit 1
fi

# change password
echo ${USER_NAME}:${PASSWORD} | chpasswd 
if [[ "${?}" -ne "0" ]]
then
    echo "Something went wrong."
    exit 1
fi

# force password change on first login
passwd -e ${USER_NAME}

# get hostname
HOSTNAME=$(hostname)

# display username, password and hostname
echo "Account created with username: ${USER_NAME}, password:${PASSWORD} at host:${HOSTNAME}."

