#!/bin/bash
# display stuff in this script

# display text
echo 'hi'

# assign to variable
WORD='script'

# display variable
echo "$WORD"

# single quote variable assignment --> not working
echo '$WORD'

#string with variable
echo "This is a shell $WORD"

# alternative syntax for variable displaying
echo "This is a shell ${WORD}"

# append text to variable
echo "This is a shell ${WORD}tttt"

#not to:
# echo "This is a shell $WORDtttt"

# new variable
ENDING='ed'

# string concatenation
echo "this is ${WORD}${ENDING}."

# variable reassignment
ENDING='ing'
echo "this is ${WORD}${ENDING}."