#!/bin/bash
source "/opt/sb/sb-pipeline.sh"
set -e

# -----------------------------------------------------
# Settings
# -----------------------------------------------------
source "_pipeline/config.sh"

# FIXME: use a more specific query? based on a tag (e.g. app_name/env/stage)?
IMAGE_NAME=$(bnw_name $APP_NAME $BRANCH_NAME $ENVIRONMENT base $REGION)
IMAGE_NAME="${ECR_URL}/${IMAGE_NAME}"

ALERT_CONFIG_FILE="_monitoring/alerts/containers.yaml"
ALERT_NAME="$(bnw_name $APP_NAME $BRANCH_NAME $ENVIRONMENT $APP_STAGE $REGION)_running"
# Warning: There is a known issue where the extra_args values cannot contain spaces
ALERT_EXTRA_ARGS="app_name=${APP_NAME},alert_name=${ALERT_NAME},image_name=${IMAGE_NAME}"

# -----------------------------------------------------
# Setup alerts
# -----------------------------------------------------
create_alert $ALERT_CONFIG_FILE \
             $ALERT_EXTRA_ARGS \
             $ALERT_NAME
