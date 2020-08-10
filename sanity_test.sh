#!/usr/bin/env bash

# Exit script if you try to use an uninitialized variable.
set -o nounset

# Exit script if a statement returns a non-true return value.
set -o errexit

# Use the error status of the first failure, rather than that of the last item in a pipeline.
set -o pipefail

if curl -s --retry 10 "http://localhost" | grep '<div id="app">'
then
    echo "Looking NICE"
else
    echo "ERROR"
fi
