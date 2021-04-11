#!/bin/bash
set -xu

while IFS= read -r -d '' file; do
    grep -rli TODO "$file"
    return_code=$?
    if [ $return_code -eq 0 ]; then
        echo "TODO found in code"
        exit 1
    elif [ $return_code -ne 1 ]; then
        echo "Error while detecting TODOs in code"
        exit 1
    fi
done< <(find . -type f -name '*.rs' -print0)
echo "No TODO found in code"
