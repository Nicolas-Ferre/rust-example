#!/bin/bash
set -xeu

add_mutation_annotations() {
    set +x
    if [ -f "$1" ]; then
        echo "Add mutation annotation in $1..."
        replace=1
        while IFS= read -r line; do
            if [[ "$line" =~ .*"#[cfg(test)]".* ]]; then
                replace=0
            fi
            if [[ "$line" =~ .*" fn ".* ]] || [[ "$line" =~ ^"fn ".* ]] && [ $replace -eq 1 ]; then
                echo "#[::mutagen::mutate] $line" >> "$1.tmp"
            else
                # Fix to avoid "annotation needed" due to a bug with serde_json (https://github.com/llogiq/mutagen/issues/164)
                line=$(echo "$line" | sed -e "s/assert_eq!(\(.*\), &\[\])/assert!(\1.is_empty())/")
                line=$(echo "$line" | sed -e "s/assert_eq!(\(.*\), \[\])/assert!(\1.is_empty())/")
                line=$(echo "$line" | sed -e "s/assert_eq!(\(.*\), Vec::new())/assert!(\1.is_empty())/")
                line=$(echo "$line" | sed -e "s/assert_eq!(\(.*\), vec!\[\])/assert!(\1.is_empty())/")

                echo "$line" >> "$1.tmp"
            fi
        done < "$1"
        rm "$1"
        mv "$1.tmp" "$1"
    fi
    set -x
}

IFS=";"
for crate_path in $CRATE_PATHS; do
    cd "$crate_path"
    while IFS= read -r -d '' file; do
        add_mutation_annotations "$file"
    done< <(find ./src -type f -name '*.rs' -print0)
    echo "Annotations added."
    echo "Add mutagen dependency in Cargo.toml..."
    sed -i -re "s;(\[dependencies\]);\1\nmutagen = { git = \"https://github.com/llogiq/mutagen\", rev = \"$MUTAGEN_COMMIT\" };" Cargo.toml
    echo "Dependency added."

    log_path=log.txt
    cargo clean
    cargo test --no-run --verbose
    cargo-mutagen | tee $log_path
    killed=$(grep -o '([^"]*%) mutants killed' $log_path | grep -o '[0-9.]*')
    rm $log_path
    failure=$(awk 'BEGIN{ print '"$killed"'<'"$MUTAGEN_THRESHOLD"' }')
    if [ "$failure" -eq "1" ]; then
        echo "Mutation tests have failed with $killed% of killed mutants instead of at least $MUTAGEN_THRESHOLD%."
        exit 1
    fi
    cd -
done
