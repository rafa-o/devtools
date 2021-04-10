#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Missing file extension or search argument(s)."
  exit 0
fi

# accepts 3rd parameter as path to folder to execute lookup
if [ -z "$3" ]; then
  LOOKUP_FOLDER=$(pwd)
else
  LOOKUP_FOLDER=$3
fi

file_extension=$1
search_term=$2

COUNT=0
MATCHES=0
for i in $(find $LOOKUP_FOLDER -type f -name "*.${file_extension}"); do
  OCCURRENCES=$(cat $i | grep -o -i $search_term | wc -l)
  if [ "$OCCURRENCES" -gt 0 ]; then
    # replaces LOOKUP_FOLDER with '.' when folder is
    # not passed as argument to shorten the output
    if [ -z "$3" ]; then
      printf "$OCCURRENCES ${i/$LOOKUP_FOLDER/.}\n"
    else
      printf "$OCCURRENCES $i\n"
    fi

    MATCHES=$(($MATCHES+1))
  fi

  COUNT=$(($COUNT+1))
done

printf "\nTotal files checked: $COUNT\n"
printf "Found '$search_term' in $MATCHES files.\n"