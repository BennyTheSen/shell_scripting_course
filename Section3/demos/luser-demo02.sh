#!/bin/bash

# display uid and username of user executing this script
# display if user is root or not

# Display UID
echo "Your UID is $UID"

# display username
USER_NAME=$(id -un)
echo "username is $USER_NAME"

# display if user is root or not (0 is root UID)
if [[ "${UID}" -eq 0 ]]
then
    echo 'You are root'
else
    echo 'You are not root'
fi