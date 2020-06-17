#!/bin/bash
source "/opt/sb/sb-pipeline.sh"
set -e
source "_pipeline/config.sh"

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <result-status> <message>"
  exit 1
fi
# valid statuses are 'fail' 'success' 'info' 'warning'
status="${1}"
msg="${2}"

# In this example, we only notify build results for the master branch, you can
# tune this according to your needs, look into config.sh for ENV variables
if [ "${BRANCH_NAME}" == "master" ]; then
  slack_notification "${APP_NAME}" "${APP_SLACK_DEPLOYMENT_CHANNEL}" "${status}" "${msg}"
fi
