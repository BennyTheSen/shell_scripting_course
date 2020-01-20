#!/bin/bash

# script deletes a user

# enforce root execution 
if [[ "${UID}" -ne "0" ]]
then
    echo "please run script with superuser" >&2
    exit 1
fi

# assume first arg user to delete
USER="${1}"

# delete user
userdel $USER

# make sure user got deleted
if [[ ${@} -ne 0 ]]
then 
    echo "Something went wrong" >&2
    exit 1
fi

# tell user that acocunt was deleted
echo "The account $USER was deleted."

exit 0
