#!/bin/bash
set -xeu

coverage=$(grep -m 1 '<abbr title' coverage/index.html | grep -o "[0-9.]*" | tail -1)
failure=$(awk 'BEGIN{ print '"$coverage"'<'"$COV_THRESHOLD"' }')
if [ "$failure" -eq "1" ]; then
    echo "Coverage has failed with $coverage% instead of at least $COV_THRESHOLD%."
    exit 1
else
    echo "Coverage has successfully passed with $coverage%."
fi
