#!/bin/bash
set -xeu

cargo kcov --all --lib --verbose -- --exclude-pattern=/.cargo,/lib/ --exclude-line "$KCOV_EXCLUDED_LINES" --exclude-region "$KCOV_EXCLUDED_REGION" --verify --clean
coverage=$(grep -o '\"covered\":\"[^"]*\"' target/cov/index.js | grep -o '[0-9.]*')
failure=$(awk 'BEGIN{ print '"$coverage"'<'"$KCOV_THRESHOLD"' }')
if [ "$failure" -eq "1" ]; then
    echo "Coverage has failed with $coverage% instead of at least $KCOV_THRESHOLD%."
    exit 1
else
    echo "Coverage has successfully passed with $coverage%."
fi
