#!/bin/bash

. /home/pi/backups/scripts/backup-functions.sh

BASE_DIR="/home/pi/backups"
WORK_DIR="$BASE_DIR/work"
ARCHIVE_DIR="$BASE_DIR/archive"
BACKUP_PREFIX="redmine-"

NOW=$(date +"%Y-%m-%d_%H-%M-%S")

DB_NAME="redmine_default"
DB_USER="redmine_default"
DB_DUMP_DIR="$WORK_DIR/sql"
DB_DUMP_NAME="$DB_DUMP_DIR/$BACKUP_PREFIX$NOW-db-$DB_NAME.sql"

FTP_HOST="backup.lg-nas.fritz.box"
FTP_TARGET_DIR="/volume1/FTP/backups/redmine"
FTP_TRANSFER_DIR="$BASE_DIR/transfer"

TAR_FILES_SOURCE="/var/lib/redmine/default/files/"
TAR_SQL_SOURCE="$WORK_DIR"
TAR_TARGET="$WORK_DIR/$BACKUP_PREFIX$NOW-files.tar"


mkdir -p $WORK_DIR
mkdir -p $FTP_TRANSFER_DIR
mkdir -p $ARCHIVE_DIR
mkdir -p $DB_DUMP_DIR
