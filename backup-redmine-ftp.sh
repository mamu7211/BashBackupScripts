#!/bin/bash

. /home/pi/backups/scripts/backup-redmine-config.sh

# Count files ----------------------------

FILE_COUNT=`(ls -1 $WORK_DIR | wc -l)`

exitOnError "No files found to be transfered. Exiting."

# Check if FTP is up ---------------------

ping -q -c 1 $FTP_HOST

exitOnError "Server '$FTP_HOST' is not available, dumps were not transfered. Exiting." 0

# FTP transfer ----------------------------

log "Found $FILE_COUNT files in '$WORK_DIR' and server '$FTP_HOST' is up. Using $FTP_TARGET_DIR."

ftp -v $FTP_HOST << EOT
bin
prompt
lcd $WORK_DIR
cd $FTP_TARGET_DIR 
mput *
bye
EOT

exitOnError "FTP transfer to '$FTP_HOST' failed. Exiting." 2

# Local archiving ------------------------

mv $WORK_DIR/$BACKUP_PREFIX* $ARCHIVE_DIR/

log "FTP transfer completed, files moved to '$ARCHIVE_DIR'"

exit 0
