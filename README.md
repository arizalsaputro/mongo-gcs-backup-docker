# mongodb-gcs-backup-docker [![Docker Build Status](https://travis-ci.org/arizalsaputro/mongo-gcs-backup-docker.svg?branch=master)](https://hub.docker.com/r/arizalsaputro/mongo-gce-backup)

This project aims to provide a simple way to perform a MongoDB server/db backup using `mongo-tools` and to upload it to Google Cloud Storage. It was greatly inspired from [`https://github.com/birotaio/mongodb-gcs-backup`](https://github.com/birotaio/mongodb-gcs-backup).


## Usage

You can find the built image on [Docker Hub](https://hub.docker.com/r/arizalsaputro/mongo-gce-backup). Then, set following environment variable when running the docker container:

| Environment Variable | Required | Default | Description |
| --- | --- | --- | --- |
| GCS_KEY_FILE_PATH | YES |  | Path to service account key file. You can either mount the key file to the container or rebuild another image based on this image with additional key file |
| GCS_BUCKET | YES |  | Name of the Google Cloud Storage bucket |
| CRON_EXPRESSION | NO | 0 0 \* \* \* | Cron expression to control backup interval |
| MONGODB_HOST | NO | localhost | The host variable that will pass to `mongodump` command |
| MONGODB_PORT | NO | 27017 | The port variable that will pass to `mongodump` command |
| MONGODB_DB | NO |  | Name of the database to perform backup. Not specifying means backup all databases |
| MONGODB_USER | NO |  | In case that your mongo instance requires authentication |
| MONGODB_PASSWORD | NO |  | In case that your mongo instance requires authentication |
| MONGODB_OPLOG | NO | | Set this to `true` if you want to perform `mongodump` with `--oplog` flag on. [Read more](https://docs.mongodb.com/v3.4/reference/program/mongodump/#cmdoption-oplog) |
| BACKUP_DIR | NO | /backup | Path to directory of the backup file. |
|SLACK_ALERTS | | No |  | `true` if you want to send Slack alerts in case of failure.
|SLACK_WEBHOOK_URL| | No |  | The Incoming WebHook URL to use to send the alerts.
|SLACK_CHANNEL| | No |  | The channel to send Slack messages to.
|SLACK_USERNAME| | No |  | The user to send Slack messages as.
|SLACK_ICON| | No |  | The Slack icon to associate to the user/message.
|SLACK_ICON_URL| | No |  | The Slack icon to associate to the user/message.


## Use with `docker-compose`

```$yaml
version: '3.1'

services:
  db_backup:
      image: arizalsaputro/mongo-gce-backup
      environment:
        - MONGODB_HOST=mongo2
        - MONGODB_PORT=27017
        - CRON_EXPRESSION=0 0 * * *
        - GCS_KEY_FILE_PATH=/mongodb-gcs-backup/service-account.json
        - GCS_BUCKET=gs://name-of-backup-buckey
      secrets:
        - googlestorage
secrets:
  googlestorage:
    external: true       
```
