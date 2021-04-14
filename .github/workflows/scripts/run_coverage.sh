#!/bin/bash
set -xeu

RUSTFLAGS="-Zinstrument-coverage" cargo test --lib
grcov . --binary-path ./target/debug/ -s . -t html --branch --ignore-not-existing -o ./coverage/ --excl-start "#\[cfg\(test\)\]" --keep-only **/src/**/*
