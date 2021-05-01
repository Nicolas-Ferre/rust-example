#!/bin/bash
set -xeu

IFS=";"
version=""
for crate_path in $CRATE_PATHS; do
    cd "$crate_path"
    current_version=$(grep -m 1 '^version' Cargo.toml | cut -d '"' -f2 | tr -d '\n')
    if [ "$version" == "" ]; then
       version="$current_version"
    elif [ "$current_version" != "$version" ]; then
        echo "All crates must have the same version"
        exit 1
    fi
    cd - || exit 1
done

if [ "$version" == "" ]; then
    echo "Version not found in Cargo.toml files"
    exit 1
else
    echo "::set-output name=version::$version"
fi
