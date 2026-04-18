#!/bin/bash

############################################################

#Script was created to restore corrupted config files 

###########################################################


FILE="/Users/andrewvonrajcs/Documents/Proj/test_config"
FILE_BKUP="/Users/andrewvonrajcs/Documents/Proj/test_config.bkup"

SIZE1=$(stat -f %z "$FILE")  
SIZE2=$(stat -f %z "$FILE_BKUP") 

#stat -c %s "$FILE_BKUP" for linux boxes
#CURRENT_VERSION="/path/to/version"

if [[ -f "$FILE" && ! -s "$FILE" ]] ; then
    cat "$FILE_BKUP" > "$FILE"
    #/file/path $CURRENT_VERSION
    echo "your file is backed up and to the current version"

elif [[ "$SIZE1" -eq  "$SIZE2" ]] ; then
    #/file/path $CURRENT_VERSION
    echo "test_config is already backed up and to the current version"
    
else 
    echo "Failed to backup test_config "

fi

