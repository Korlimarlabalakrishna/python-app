#!/bin/bash

# Postgres Credentials
USER="postgres"
HOST="localhost"
PASSWORD="Power@1234"

NOW_MONTH=$(date +"%Y-%m")
THEDATE=$(date +"%d")

# Backup storage directory 
backupfolder=/home/isadmin/dbbackup 

cd $backupfolder

export PGPASSWORD="$PASSWORD"

AMAZON_S3_BUCKET="s3://local-backups-isadmin/$NOW_MONTH/$THEDATE/" 

DBS=$(psql -U $USER -t -c "SELECT datname FROM pg_database WHERE datistemplate = false;")

for DB in $DBS; do
    echo "Backing up database: $DB"
    pg_dump -U $USER -h $HOST -d $DB -F c -f "$backupfolder/$DB-$(date +%d%m%y%H%M).sql"
    zip -r "$backupfolder/$DB-$(date +%d%m%y%H%M).zip" "$backupfolder/$DB-$(date +%d%m%y%H%M).sql"
    aws s3 cp "$backupfolder/$DB-$(date +%d%m%y%H%M).zip" "$AMAZON_S3_BUCKET"
done

unset PGPASSWORD


#removing all backups from local server 

rm *.sql
rm *.zip
