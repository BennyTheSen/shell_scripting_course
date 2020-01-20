#/bin/bash 

# script generates a random password
# password length with -l and special character with -s
# verbose mode with -v

usage(){
    echo "Usage: ${0} [-vs] [-l LENGTH]" >&2
    echo "Generate a random password."
    echo "  -l LENGTH Specify password length."
    echo "  -s append a special character"
    echo "  -v increase verbosity"
    exit 1
}

log(){
    local MESSAGE="${@}"
    if [[ "$VERBOSE" = 'true' ]]
    then 
        echo "$MESSAGE"
    fi
}

# default password length
LENGTH=48

while getopts vl:s OPTION
do
    case ${OPTION} in
        v) 
            VERBOSE='true'
            log 'Verbose mode on.'
            ;;
        l) LENGTH="${OPTARG}" ;;
        s) USE_SPECIAL_CHARACTER='true' ;;
        ?) usage ;;
    esac
done

# remove the options while leaving the remaining arguments
shift "$(( OPTIND -1 ))"

if [[ "${#}" -gt 0 ]]
then
    usage
    exit 1
fi  

log 'Generating a password.'

PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c${LENGTH})
if [[ "$USE_SPECIAL_CHARACTER" = 'true' ]]
then
    log 'appending a random special character'
    SPECIAL_CHAR=$(echo '!@#$%&^*+-_=?()' | fold -w1 | shuf | head -c1)
    PASSWORD="${PASSWORD}${SPECIAL_CHARACTER}"
fi

log 'Done.'
log 'Here is the password:'
echo "${PASSWORD}"

exit 0
