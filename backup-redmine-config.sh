#!/bin/bash

. /home/pi/backups/scripts/backup-functions.sh

BASE_DIR="/home/pi/backups"
WORK_DIR="$BASE_DIR/work/redmine"
ARCHIVE_DIR="$BASE_DIR/archive/redmine"
BACKUP_PREFIX="redmine-"

NOW=$(date +"%Y-%m-%d_%H-%M-%S")

DB_NAME="redmine_default"
DB_USER="redmine_default"
DB_DUMP_NAME="$WORK_DIR/$BACKUP_PREFIX$NOW-db-$DB_NAME.sql"

FTP_HOST="backup.lg-nas.fritz.box"
FTP_TARGET_DIR="/volume1/FTP/backups/redmine"

TAR_SOURCE="/var/lib/redmine/default/files/"
TAR_TARGET="$WORK_DIR/$BACKUP_PREFIX$NOW-files.tar"
