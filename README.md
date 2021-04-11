# rust-example

[![Crates.io](https://img.shields.io/crates/v/rust_lib_example.svg)](https://crates.io/crates/rust_lib_example)
[![Docs.rs](https://img.shields.io/docsrs/rust_lib_example)](https://docs.rs/crate/rust_lib_example)
[![License](https://img.shields.io/crates/l/rust_lib_example)](https://github.com/Nicolas-Ferre/rust-example)
[![CI](https://github.com/Nicolas-Ferre/rust-example/actions/workflows/ci.yml/badge.svg)](https://github.com/Nicolas-Ferre/rust-example/actions/workflows/ci.yml)
[![Coverage with grcov](https://img.shields.io/badge/coverage-grcov-blue.svg)](https://github.com/Nicolas-Ferre/rust-example/actions/workflows/ci.yml)
[![Mutation tested with mutagen](https://img.shields.io/badge/mutation%20tested-mutagen-blue.svg)](https://github.com/Nicolas-Ferre/rust-example/actions/workflows/ci.yml)
[![Lines of code](https://tokei.rs/b1/github/Nicolas-Ferre/rust-example?category=code)](https://github.com/Nicolas-Ferre/rust-example)

## Purpose

This repository contains an example of Rust project structure.

Most of the components can be reusable in your own projects:
- Default Rust project configuration
- CI workflow to build, lint, test, check test coverage and run mutation tests

## Github Actions workflows

### Jobs

The `CI` workflow is triggered for any commit or pull request on the `develop` branch and runs the following jobs:
- Test the crate
    - Builds the project for all targets and with default features to ensure everything compiles
    - Runs unit, integration and doc tests with default features
- Run test coverage and mutation tests
    - Run [source-based coverage](https://marco-c.github.io/2020/11/24/rust-source-based-code-coverage.html) with [grcov](https://github.com/mozilla/grcov)
    - HTML coverage report is uploaded in workflow artifacts
    - Job fails if the coverage threshold is not reached
    - Mutation tests are run with [mutagen](https://github.com/llogiq/mutagen) (note that `#[mutate]` annotations are automatically added in the Rust code)
    - Job fails if the mutation threshold is not reached
- Run several lint tools
    - Run `clippy`
    - Run `rustfmt` to check code is correctly formatted
    - Run `cargo-deny` to check dependencies
    - Check all file encoding is UTF-8
    - Check all line endings is LF
    - Check there is no TODOs in Rust code

This workflow is only run on Ubuntu virtual environment.

### Settings

Settings of the `CI` workflow can be modified by in the file `.github/workflows/ci.yml`, in the `env` section:
- `RUST_VERSION_STABLE`: version of the stable Rust compiler to use
- `RUST_VERSION_NIGHTLY`: version of the nightly Rust compiler to use when required
- `MUTAGEN_COMMIT`: commit of the mutagen version to install ([from mutagen repository](https://github.com/llogiq/mutagen))
- `COV_THRESHOLD`: minimum threshold the coverage must reached to succeed the job
- `MUTAGEN_THRESHOLD`: minimum threshold the mutation tests must reached to succeed the job
- `CRATE_PATHS`: package names separated by ";" in publish order if the repository is a Cargo workspace, else "."

### Export

You can use the workflows for your own project by copying the folder `.github/workflows`.

### Run locally

[act](https://github.com/nektos/act) can be used to run the workflows on your own machine.<br>
Once installed, run `act -P ubuntu-18.04=nektos/act-environments-ubuntu:18.04` to run all the jobs.

### Workspaces

This repository contains a single crate, but the workflows should also work with a Cargo workspace.
