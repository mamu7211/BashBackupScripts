# Backup Scripts

## Usage

These scripts are used to backup a PostgreSQL database that is used by a Redmine server.

## Prerequisits

To run the scripts several prerequisits must be met.

1. scripts must be stored on the server, e.g. in a ~/backup/scripts/ folder
1. authentication for PostgreSQL and FTP ust be possible
2. local and remote folder structure must be prepared
3. crontab must be set

### Scripts

Copy the following scripts to a convenient location on your machine. They must have execution right, if necessary change them via `chmod u+x *.sh`.

|File|Description/Usage|
|---|---|
|backup-redmine-config.sh|Configuration of user-, path- and servernames.|
|backup-redmine-archive.sh|Archiving of Redmine file structure and Redmines PostgreSQL database.|
|backup-redmine-ftp.sh|FTP transfer script.|
|backup-functions.sh|Functions for logging to syslog and error handling.|

### Authentication

To allow access and not to store password these scripts rely on two authentication methods built in to the tools used.

|Tool|Authentication|
|---|---|
|pg_dump|Uses authentication stored in the users `.pgpass`, see [here](http://www.postgresql.org/docs/9.1/static/libpq-pgpass.html).|
|ftp|Uses `.netrc` authentication.|

Do not forget to change the rights so only you can read those files, change the access rights via `chmod o-r .netrc`.

### Configuration

Local folders must be set according to `backup-redmine-config.sh`. The parameters will give you a clue how to set up your machine.

|Parameter|Description|Sample|
|---|---|---|
|BASE_DIR|Base directory for backups.|"/home/pi/backups"|
|WORK_DIR|Working directory where files reside until transfered to the FTP server.|"$BASE_DIR/work/redmine"|
|ARCHIVE_DIR|Local archive where files are stored that are already transfered.|"$BASE_DIR/archive/redmine"|
|BACKUP_PREFIX|Prefix for all files created.|"redmine-"|
|NOW|Timestamp that is used in the filenames.|$(date +"%Y-%m-%d_%H-%M-%S")|
|DB_NAME|Database to backup|"redmine_default"|
|DB_USER|Database user to be used by `pg_dump`|"redmine_default"|
|DB_DUMP_NAME|Name of the DB dump.|"$WORK_DIR/$BACKUP_PREFIX$NOW-db-$DB_NAME.sql"|
|FTP_HOST|FTP Servername.|"backup.lg-nas.fritz.box"|
|FTP_TARGET_DIR|FTP remote directory.|"/volume1/FTP/backups/redmine"|
|TAR_SOURCE|Source folder of Redmine files.|"/var/lib/redmine/default/files/"|
|TAR_TARGET|Filename of the archive.|"$WORK_DIR/$BACKUP_PREFIX$NOW-files.tar"|


### Sample Folder Structure

```
// local on your redmine server

~/                    # users home, contains .netrc and .pgpass
 +--+ backups         # main backup directory
    +--+ redmine      # backup for redmine
       +--+ archive   # local archive
       |  + work      # working directory, e.g. for archiving
       + scripts      # location of *.sh

// remote on the ftp server
~/
 +--+ volume1          # FTP root folder
    +--+ FTP           #
       +--+ backups    # main backup directory
          +--+ redmine # redmine backup directory on the ftp server
``` 

### Sample Cron Settings

I have my database backed up three time, one time after morning work is done, one time in the evening and during the night.

The FTP transfer will occur each 15 minutes, if there are no files, it will exit.


```
0 3,12,18 * * * /home/pi/backups/scripts/backup-redmine-archive.sh
*/15 * * * * /home/pi/backups/scripts/backup-redmine-ftp.sh
```

## Open Points
