#!/bin/bash

# script creates account 
# promted to enter name and password

# ask for username
read -p 'Enter username: ' USER_NAME

# ask for real name
read -p 'Enter real name: ' COMMENT

# ask for password
read -p 'Enter password: ' PASSWORD

#create the user
useradd -c "${COMMENT}" -m ${USER_NAME}

# set passsword for user
echo ${USER_NAME}:${PASSWORD} | chpasswd 

# force password change on first login
passwd -e ${USER_NAME}