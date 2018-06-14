#!/bin/bash

## Author: Justin Fruitticher
version=1.0

###*** FUNCTIONS ***###
function errorText {
    echo -e "Version: $version\n Usage: ./autoCompile -f [File pathway]"
}

## File select
while getopts f: opt; do
case $opt in

f) FILENAME=$OPTARG;; 

esac
done

## Check if filename is empty
if [[ -z ${FILENAME} ]]; then
    errorText
    exit 1
fi

pandoc -s -t context $FILENAME -o $FILENAME.pdf

## Back end
TEMPFILE=$(stat -c%s "$FILENAME")
while :
do

CURRENTFILE=$(stat -c%s "$FILENAME") 

if [ "$TEMPFILE" != "$CURRENTFILE" ]; then 
    pandoc -s -t context $FILENAME -o $FILENAME.pdf
    echo -e "compiled and output to $FILENAME"
    TEMPFILE=$(stat -c%s "$FILENAME")
fi

done
