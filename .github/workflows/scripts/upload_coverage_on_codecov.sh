#!/bin/bash
set -xeu

if [ -n "$CODECOV_TOKEN" ]; then
    grcov . --binary-path ./target/debug/ -s . -t lcov --branch --ignore-not-existing -o ./lcov.info --excl-start "#\[cfg\(test\)\]" --keep-only **/src/**/*
    bash <(curl -s https://codecov.io/bash) -f lcov.info
else
    echo "Coverage not uploaded on Codecov because CODECOV_TOKEN environment variable is not set"
fi
