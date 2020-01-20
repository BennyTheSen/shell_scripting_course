#!/bin/bash


log() {
    # this function sends a message to syslog and stdout if verbose is true
    local MESSAGE="${@}"
    if [[ "$VERBOSE" = 'true' ]]
    then
        echo "${MESSAGE}"
    fi
    logger -t luser-demo10.sh "${MESSAGE}"
}

backup_file(){
    # this function creates a backup of a file returns non-zero status on error
    local FILE="${1}"

    # make sure file exists
    if [[ -f "${FILE}" ]]
    then
        local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
        log "Backing up ${FILE} to ${BACKUP_FILE}"

        # exit status willl be exit status of cp command
        cp -p ${FILE} ${BACKUP_FILE}
    else
        # file does not exist return non zero exit status
        return 1
    fi
}

readonly VERBOSE='true'
log 'Hello'
log 'this is fun'

backup_file '/etc/passwd'

# make decision based on return 
if [[ ${?} -eq 0 ]]
then    
    log "it worked"
else
    log "it failed"
    exit 1
fi