#!/bin/bash
source "/opt/sb/sb-pipeline.sh"
set -e
source "_pipeline/config.sh"

# ------------------------------------------------------------------------------
# Build docker image
#
# If you want to know more about avaliable environment variables during the
# build read docs in the link below.
# https://github.com/simplybusiness/brave_new_world/blob/master/docs/PIPELINE_CONFIGURATION.md#at-build-time
#
# You define additional settings to be used in the build process using the
# variables available at https://github.com/simplybusiness/brave_new_world/blob/master/docs/PIPELINE_CONFIGURATION.md
# (e.g. export APP_HA_L7_CONTAINER_DOCKER_BUILD_ARGS='--target release'). Note
# that if you define variables here, they will override the values defined in
# _pipeline/config.sh.
# ------------------------------------------------------------------------------
console_h1 'Building image'
bnw_app_build
