#!/bin/bash
set -xeu

version="$1"
new_version=$(semver -i minor "$version")
IFS=";"
for crate_path in $CRATE_PATHS; do
    cd "$crate_path"
    sed -i "s/^version \?=.*$/version = \"$new_version\"/g" Cargo.toml
    cd - || exit 1
done
