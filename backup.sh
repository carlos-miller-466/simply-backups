#!/bin/bash

# Copyright 2021 Carlos Miller

# simply-backups
# Beta Release Candidate 1
# By Carlos Miller

BACKUP_DIR="/home/$USER/Backups"

if [[ -d $BACKUP_DIR ]]; then
    echo "[x] Backup Directory"
else
    echo "[ ] Backup Directory"
    echo "[*] Making directory $BACKUP_DIR..."
    mkdir $BACKUP_DIR
fi

# Items to backup. THIS SHOULD BE LOADED FROM A PLAINTEXT FILE!
# These are some temporary defaults.
INCLUDE='Documents/ Downloads/ Games/ Pictures/ .config .local .minecraft .steam .ssh .mono .bash_logout .bash_profile .bashrc .gnupg .Xauthority .xprofile .zprofile'

# Show items to backup (should have a confirmation method.)
# Only the final operation in this loop does anything dangerous.
echo -e [x] Items to Backup\\n
for item in $INCLUDE
do
    if [[ -d $item ]]
    then # DIRECTORIES
        if [[ ${#item} -lt 7 ]]
        then
            echo -e "$item \\t\\t DIR"
        else
            echo -e "$item \\t DIR"
        fi
    elif [[ -f $item ]]
    then # FILES
        if [[ ${#item} -lt 7 ]]
        then
            echo -e "$item \\t\\t FILE"
        else
            echo -e "$item \\t FILE"
        fi
    else
        if [[ ${#item} -lt 7 ]]
        then
            echo -e "$item \\t\\t NULL"
        else
            echo -e "$item \\t NULL"
        # REMOVE NULL ITEMS FROM $INCLUDE
        fi
    fi
    # Add each item and it's contents to a temporary directory.
    # THE FOLLOWING IS TURNED OFF DURING TESTING:
    # cp -Lr $item $BACKUP_DIR/temp
done

echo -e "\\n[x] Copied relevant data to $BACKUP_DIR/temp"
echo -e "[x] Archiving files with tar..."
BACKUP_NAME=$( date +"backup_%Y-%W.tar" )
echo "[*] Backup name: $BACKUP_NAME"
# tar -cf $BACKUP_DIR/$BACKUP_NAME $BACKUP_DIR/temp
echo "[x] Archive made"
echo "[x] Compressing backup for long term storage..."
# bzip2 $BACKUP_DIR/$BACKUP_NAME
echo "[x] Compressed"
