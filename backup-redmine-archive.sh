#!/bin/bash

. /home/pi/backups/scripts/backup-redmine-config.sh

# Dump database into file ----------------

pg_dump -U $DB_USER $DB_NAME > $DB_DUMP_NAME

exitOnError "Error while dumping database '$DB_NAME' into '$DB_DUMP_NAME'. Exiting."

# TAR and gZip files ---------------------

tar cvf $TAR_TARGET $TAR_SOURCE 
exitOnError "Error while archiving files. Exiting."

tar --append --file=$TAR_TARGET $DB_DUMP_NAME 
exitOnError "Error while appending SQL file to archive. Exiting."

gzip $TAR_TARGET
exitOnError "Error while compressing archive. Exiting."

rm $DB_DUMP_NAME
exitOnError "Error while cleaning up files. Exiting."


