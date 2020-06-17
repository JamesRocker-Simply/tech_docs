#!/bin/bash
# ------------------------------------------------------------------------------
# Required settings
# ------------------------------------------------------------------------------
# accepted APP_TEMPLATE values are ha_l7_container, ha_l7_instance, single_l4_instance, serverless
export APP_TEMPLATE='ha_l7_container'

# This is the name that will used by the bnw tools for this app
export APP_NAME='tech_docs'

# APP_STAGE is the Organisation Unit (OU) your app will be deployed to.
# This is not related to the "stage" in ruby, or serverless framework, etc.
# In the near future, the variable APP_STAGE will be deprecated in favour of OU.
export APP_STAGE='production'

# See the list of valid teams in this file: https://github.com/simplybusiness/brave_new_world/blob/master/config/global.yaml (in the 'teams' section.
export APP_TEAM_KMS_KEY_ACCESS='people-analytics'

# ------------------------------------------------------------------------------
# APP_TEMPLATE-specific parameters (See all options available here:
# https://github.com/simplybusiness/brave_new_world/blob/master/docs/PIPELINE_CONFIGURATION.md)
# ------------------------------------------------------------------------------

# Port exposed by the application
export APP_PORT='4444'
# Health check path
export APP_HA_L7_CONTAINER_HEALTH_CHECK_PATH='/heath'
# When running docker build for the release image, specify a build target so we
# don't build unnecessary stages
export APP_HA_L7_CONTAINER_DOCKER_BUILD_ARGS=''

# This slack channel for application release notifications
export APP_SLACK_DEPLOYMENT_CHANNEL='people-analytics-release'
