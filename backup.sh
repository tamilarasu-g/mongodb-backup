#!/bin/bash

#Exit Status Function
exit_status()
{
    if [[ "${?}" -ne 0 ]]
    then
        echo "$1"
        exit 1
    fi
}

#Directory
DIRECTORY_PATH="$HOME/backup"

# Logfile
LOG_FILE="log.txt"
LOG_PATH="$DIRECTORY_PATH/$LOG_FILE"

# Make sure the backup directory exists"
if [ ! -d "$DIRECTORY_PATH" ]; then
    mkdir -p "$DIRECTORY_PATH"    
fi

exit_status "Could not create the required directory !!!" &> "$LOG_PATH"

#Date and Time
TODAY_DATE=$(date +%d-%m-%Y)
TIME_NOW_LOCAL=$(date +%H:%M:%S)

#Credentials
USERNAME="feedback"
PASSWORD="feedback"
DATABASE_NAME="feedback"

#File Name
FILE_NAME="backup-$TODAY_DATE-$TIME_NOW_LOCAL.gz"

#Final Path
FINAL_PATH="$DIRECTORY_PATH/$FILE_NAME"

# IP details
IP=localhost
PORT=27017

# MongoDump Command
mongodump --uri="mongodb://$USERNAME:$PASSWORD@$IP:$PORT/$DATABASE_NAME" --gzip  --archive="$FINAL_PATH" &> "$LOG_PATH"
# echo "Backup In Progress....."
# echo "Please Wait....."

# exit_status echo "Could not finish the backup !
# Check the $LOG_FILE file present in the $FINAL_PATH/$LOG_FILE to check for the details"
