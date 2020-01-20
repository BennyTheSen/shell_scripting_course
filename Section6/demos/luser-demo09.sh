#!/bin/bash

# script demonstrates case statement 

# if version
# if [[ "${1}" = 'start' ]]
# then
#     echo 'Starting.'
# elif [[ "${1}" = 'stop' ]]
# then
#     echo 'Stopping.'
# elif [[ "${1}" = 'status' ]]
# then
#     echo 'Status.'
# else 
#     echo 'Supply a valid option' >&2
#     exit 1
# fi

# case version
case ${1} in 
    start) echo 'Starting.' ;;
    stop) echo 'Stopping.' ;;
    status|state|--state|--status) echo 'Status.' ;;
    *) 
        echo 'Supply a valid option' >&2 
        exit 1     
        ;;
esac

