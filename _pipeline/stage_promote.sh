#!/bin/bash
source "/opt/sb/sb-pipeline.sh"
set -e
source "_pipeline/config.sh"

# ------------------------------------------------------------------------------
# Promote stage
# ------------------------------------------------------------------------------
# In the stage_promote, we recommend running the final checks (e.g. test the
# image) before promoting the image you just built to a 'release' image.
# After the final checks pass, promote tag the image and promote it using
# bnw_app_promote

# ------------------------------------------------------------------------------
# Test docker image
# ------------------------------------------------------------------------------
# console_h1 'Testing image'
# # The two gems below should go to the Gemfile in a ruby app, however,
# # we are deliberately keeping these here to demonstrate how non-ruby apps
# # can use those gems to test their Docker Images and/or AMIs
# # gem install serverspec docker-api
# # bundle exec rspec _spec_pipeline/build --format documentation
# # try goss? https://github.com/aelsabbahy/goss
# # or google's https://github.com/GoogleContainerTools/container-structure-test

# ------------------------------------------------------------------------------
# Creating registry and pushing the image to it
# ------------------------------------------------------------------------------
bnw_app_promote
