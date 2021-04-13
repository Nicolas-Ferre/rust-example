#!/bin/bash
set -xeu

grcov . --binary-path ./target/debug/ -s . -t lcov --branch --ignore-not-existing -o ./lcov.info --excl-start "#\[cfg\(test\)\]" --keep-only **/src/**/*
bash <(curl -s https://codecov.io/bash) -f lcov.info || echo 'Codecov failed to upload'
