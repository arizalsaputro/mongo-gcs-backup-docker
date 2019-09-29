#!/bin/sh

CRON_EXPRESSION=${CRON_EXPRESSION:-59 23 * * *}
echo "$CRON_EXPRESSION /mongodb-gcs-backup/backup.sh" | crontab -

if [[ -z $GCS_KEY_FILE_PATH ]] || [[ -z $GCS_BUCKET ]]
then
  echo "Environment variables are not correctly set up. Please refer to usage instructions."
  sleep 5
  exit 1
fi

# support docker-compose secret
if [ -f /run/secrets/service_account ]; then
	eval "cp /run/secrets/googlestorage $GCS_KEY_FILE_PATH"
fi

/usr/sbin/crond -f