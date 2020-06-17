#!/bin/bash
source "/opt/sb/sb-pipeline.sh"
set -e
source "_pipeline/config.sh"

# ------------------------------------------------------------------------------
# Deploy the image that was built and pushed on the 'Build' and 'Promote'
# stages. This includes:
# * Creating (or updating) load balancers and rules
# * Starting the running containers
# * Creating the default DNS entries
# For blue/green or red/black deployments only one side of the application
# cluster is deployed at a time. This stage (deploy), deploys to the passive
# side.
# After 'Deploy', the app is available to test. To make it available to end
# users you need to run the 'Publish' step.
# ------------------------------------------------------------------------------
# Setting APP_HA_L7_CONTAINER_EXTRA_ENV1 so there is an ENV var called
# BUCKET_NAME available in the container
APP_BUCKET_NAME="$(bnw_name $APP_NAME $BRANCH_NAME $ENVIRONMENT $APP_STAGE $REGION)"
export APP_HA_L7_CONTAINER_EXTRA_ENV1="BUCKET_NAME=${APP_BUCKET_NAME}"

bnw_app_deploy

# ------------------------------------------------------------------------------
# Posting URL to the PR
# This adds a link to the running application in the PR raised for the current
# branch (if a PR has been created),
# ------------------------------------------------------------------------------
# line breaks are not allowed (JSON does not allow) so the message be a single
# line String. Use '\n' for line breaks in the message
msg="${APP_NAME} ${ENVIRONMENT} ${APP_STAGE} ${REGION} deployment completed!\n\nThe deployed URL is: https://$(get_passive_app_url $APP_NAME $APP_STAGE)\n\n*Note that the deployment URL may not be the active URL if you are using blue-green or red-black deployments*"
github_pr_post_comment "$msg"
