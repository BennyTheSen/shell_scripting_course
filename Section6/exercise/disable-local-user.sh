#!/bin/bash

# script allows for a local Linux account to be disabled, deleted, and optionally archived.

usage(){
    echo "Usage: ${0} [-dra] USER [USERNAME]..." >&2
    echo "Disable a user account"
    echo "  -d Delete the account instead of disable it."
    echo "  -r Remove home directory of the account"
    echo "  -a Creates an archive of the home directory associated with the accounts(s) and stores
the archive in the /archives directory"
    exit 1
}

# enforce root execution 
if [[ "${UID}" -ne "0" ]]
then
    echo "please run script with superuser" >&2
    exit 1
fi

# get arguments
while getopts dra OPTION
do
    case ${OPTION} in
        d)  DELETE='true' ;;
        r)  REMOVE='-r' ;;
        a)  ARCHIVE='true';;
        ?)  echo "${OPTION}"
            usage    
            ;;
    esac
done

ARCHIVE_DIR='/archive'

# remove the options while leaving the remaining arguments
shift "$(( OPTIND -1 ))"

# at least one username required
if [[ "${#}" -lt 1 ]]
then
    usage
    exit 1
fi  

# Loop through all the usernames supplied as arguments.
for USERNAME in "${@}"
do

# Refuses to disable or delete any accounts that have a UID less than 1,000
    USERID=$(id -u ${USERNAME})
    if [[ "${USERID}" -lt 1000 ]]
    then
        echo "User-id less than 1000 (${USERNAME}:${USERID}). Only system accounts should be modified by system administrators"
        exit 1
    fi

    # archive
    if [[ ${ARCHIVE} = 'true' ]]
    then
        echo "Creating ${ARCHIVE_DIR} directory."
        mkdir -p ${ARCHIVE_DIR}

        HOME_DIR="/home/${USERNAME}"
        ARCHIVE_FILE="${ARCHIVE_DIR}/${USERNAME}.tgz"

        if [[ -d "${HOME_DIR}" ]]
        then
            echo "Archiving ${HOME_DIR} to ${ARCHIVE_FILE}"
            tar -zcf ${ARCHIVE_FILE} ${HOME_DIR} &> /dev/null
            if [[ "${?}" -ne 0 ]]
            then
                echo "Could not create ${ARCHIVE_FILE}." >&2
                exit 1
            fi
        else
            echo "${HOME_DIR} does not exist or is not a directory." >&2
            exit 1
        fi
    fi

    
    if [[ ${DELETE} = 'true' ]]
    # delete user
    then
        echo "Deleting user ${USERNAME}"
        userdel ${REMOVE} ${USERNAME} 
        
        #check if deletion was succesfull
        if [[ "${?}" -ne 0 ]]
        then
            echo "The account ${USERNAME} was NOT deleted." >&2
            exit 1
        fi
        echo "The account ${USERNAME} was deleted."
    #expire user
    else
        echo "Disable user ${USERNAME}"
        chage -E 0 ${USERNAME}

        #check if disabling was succesfull
        if [[ "${?}" -ne 0 ]]
        then
            echo "The account ${USERNAME} was NOT disabled." >&2
            exit 1
        fi
        echo "The account ${USERNAME} was disabled."
    fi
done