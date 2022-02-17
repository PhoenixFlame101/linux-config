#!/bin/bash

# The first arguement after runcpp.sh should either be --runonly or any other arguement
# if you want to build as well, since the arguement positions are hardcoded

# Checks if an arguement (filename) is provided
if [[ $# -eq 1 ]]; then
    echo 'No file provided; Exiting...'
    exit 0
fi

mkdir -p ./bin                  # Makes the directory bin in the current folder it doens't exist 

FILEPATH=$HOME/.runcpp          # Temp location so nothing
BINFILE=$HOME/.runcppbin        # dangerous happens or something idk
FILEIN=$HOME/.runcppfilein
FILENAME=$(basename $FILEPATH)

if [[ $2 == *"/"* ]]; then      # Check if the arguement is a full/relative path, or just a filename
    FILEPATH=$2
else
    FILEPATH=$PWD/$2            # Adds the full path to the filename and stores it in the FILEPATH var
fi

if [[ $3 == *"/"* ]]; then
    FILEIN=$3
else
    FILEIN=$PWD/$3
fi

# Runs if the --runonly parameter was passed
if [[ $1 == "--runonly" ]]; then
    if [[ $FILEPATH == *.cpp ]]; then
        FILENAME=$(basename $FILEPATH .cpp)
        if [[ ${#3} != 0 ]]; then
            ./bin/$FILENAME < $FILEIN
            exit 1
        else
            ./bin/$FILENAME
            exit 1
        fi
    elif [[ $FILEPATH == *.c ]]; then
        FILENAME=$(basename $FILEPATH .c)
        if [[ ${#3} != 0 ]]; then
            ./bin/$FILENAME < $FILEIN
            exit 1
        else
            ./bin/$FILENAME
            exit 1
        fi
    fi
fi

# Runs if the file has .cpp extension
if [[ $FILEPATH == *.cpp ]]; then
    FILENAME=$(basename $FILEPATH .cpp)
    if [[ $3 != "--nofile" ]]; then
        if [[ ${#3} != 0 ]]; then
            g++ $FILEPATH -std=c++11 -O2 -Wall -o $(dirname $FILEPATH)/bin/$FILENAME && $(dirname $FILEPATH)/bin/$FILENAME < $FILEIN
        else
            g++ $FILEPATH -std=c++11 -O2 -Wall -o $(dirname $FILEPATH)/bin/$FILENAME && $(dirname $FILEPATH)/bin/$FILENAME < file.in
        fi
    else
        g++ $FILEPATH -std=c++11 -O2 -Wall -o $(dirname $FILEPATH)/bin/$FILENAME && $(dirname $FILEPATH)/bin/$FILENAME
    fi

# Runs if the file has .c extension
elif [[ $FILEPATH == *.c ]]; then
    FILENAME=$(basename $FILEPATH .c)
    if [[ ${#3} != 0 ]]; then
        gcc $FILEPATH -o $(dirname $FILEPATH)/bin/$FILENAME && $(dirname $FILEPATH)/bin/$FILENAME < $FILEIN
    else
        gcc $FILEPATH -o $(dirname $FILEPATH)/bin/$FILENAME && $(dirname $FILEPATH)/bin/$FILENAME
    fi
fi
