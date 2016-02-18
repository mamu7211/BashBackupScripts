#!/bin/bash

. /home/pi/backups/scripts/backup-redmine-config.sh

# Dump database into file ----------------

pg_dump -U $DB_USER $DB_NAME > $DB_DUMP_NAME

exitOnError "Error while dumping database '$DB_NAME' into '$DB_DUMP_NAME'. Exiting."

# TAR and gZip files ---------------------

cd $TAR_FILES_SOURCE
tar cvf $TAR_TARGET . 

exitOnError "Error while archiving files. Exiting."

cd $DB_DUMP_DIR
tar --append --file=$TAR_TARGET $DB_DUMP_NAME 
exitOnError "Error while appending SQL file to archive. Exiting."

cd $WORK_DIR
gzip $TAR_TARGET
exitOnError "Error while compressing archive. Exiting."

rm $DB_DUMP_NAME
exitOnError "Error while cleaning up files. Exiting."

mv $WORK_DIR/*.gz $FTP_TRANSFER_DIR
