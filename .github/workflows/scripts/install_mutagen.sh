#!/bin/bash
set -xeu

git clone https://github.com/llogiq/mutagen
cd mutagen
git checkout "$MUTAGEN_COMMIT"
cd ..
cargo install --path ./mutagen/mutagen-runner --debug
