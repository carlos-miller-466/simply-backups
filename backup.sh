#!/bin/bash

# Copyright 2021 Carlos Miller

# simply-backups
# Beta Release Candidate 1
# By Carlos Miller

BACKUP_DIR="/home/$USER/Backups"

if [[ -d $BACKUP_DIR ]]; then
    echo '[x] Backup Directory'
else
    echo '[ ] Backup Directory'
    echo '[*] Making directory /home/carlos/Backups...'
    mkdir $BACKUP_DIR
fi

# Items to backup.
INCLUDE='Documents/ Downloads/ Games/ Mail/ Pictures/ .config .local .minecraft .steam .mono .bash_logout .bash_profile .bashrc .gnupg .steampath .steampid .Xauthority .xprofile .zprofile'

# Show items to backup (should have a confirmation method.)
echo -e [x] Items to Backup\\n
for item in $INCLUDE
do
    if [[ -d $item ]]
    then # DIRECTORIES
        if [[ ${#item} -lt 7 ]]
        then
            echo -e $item \\t\\t DIR
        else
            echo -e $item \\t DIR
        fi
    else # FILES
        if [[ ${#item} -lt 7 ]]
        then
            echo -e $item \\t\\t FILE
        else
            echo -e $item \\t FILE
        fi
    fi
    # Add each item and it's contents to a temporary directory.
    # cp -Lr $item $BACKUP_DIR/temp
done

echo -e \\n[x] Copied relevant data to $BACKUP_DIR/temp
echo -e [x] Archiving files with tar...
BACKUP_NAME=$( date +"backup_%Y-%W.tar" )
echo [*] Backup name: $BACKUP_NAME
tar -cf $BACKUP_DIR/$BACKUP_NAME $BACKUP_DIR/temp
echo [x] Archive made
echo [x] Compressing backup for long term storage...
bzip2 $BACKUP_DIR/$BACKUP_NAME
echo [x] Compressed
