#!/bin/bash
source "/opt/sb/sb-pipeline.sh"
set -e

# -----------------------------------------------------
# Settings
# -----------------------------------------------------
source "_pipeline/config.sh"

bnw_app_passive_cleanup
