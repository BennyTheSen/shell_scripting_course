#!/bin/bash

# display uid and username of user executing this script
# display if user is vagrant user or not

# Display UID
echo "Your UID is $UID"

# only display UID if not 1000
UID_TO_TEST_FOR='1000'
if [[ ${UID} -ne $UID_TO_TEST_FOR ]]
then
    echo "Your UID does not match $UID_TO_TEST_FOR"
    exit 1
fi

# display username
USER_NAME=$(whoami)

# test if username command succeeded
if [[ "${?}" -ne 0 ]]
then 
    echo "Whoami command does not execute succesfully"
    exit 1
fi
echo "username is $USER_NAME"

# string conditional
USER_NAME_TO_TEST_FOR='benny'
if [[ "${USER_NAME}" = "${USER_NAME_TO_TEST_FOR}" ]]
then 
    echo "Your username matches $USER_NAME_TO_TEST_FOR"
fi

# test for !=
if [[ "${USER_NAME}" != "${USER_NAME_TO_TEST_FOR}" ]]
then 
    echo "Your username not matches $USER_NAME_TO_TEST_FOR"
    exit 1
fi

exit 0