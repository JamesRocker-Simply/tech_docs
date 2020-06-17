#!/bin/bash
source "/opt/sb/sb-pipeline.sh"
set -e
source "_pipeline/config.sh"

# ------------------------------------------------------------------------------
# Publish
# The makes the build 'live', i.e becomes active and ready to receive user
# traffic. When the publish stage is executed:
# * Rules to match Any 'friendly' DNS names are created on the load balancer
# * In blue/green or red/black deployment the active side is moved to the side
#   deployed at the 'Deploy' stage
# ------------------------------------------------------------------------------
bnw_app_publish

# ------------------------------------------------------------------------------
# Posting URL to the PR
# This adds a link to the running application in the PR raised for the current
# branch (if a PR has been created),
# ------------------------------------------------------------------------------
# line breaks are not allowed (JSON does not allow) so the message be a single
# line String. Use '\n' for line breaks in the message
msg="${APP_NAME} ${ENVIRONMENT} ${APP_STAGE} ${REGION} published!\n\nThe application URL (active) is: https://$(get_app_url $APP_NAME $APP_STAGE)"
github_pr_post_comment "$msg"
