# Example of Rust project

[![Crates.io](https://img.shields.io/crates/v/rust_lib_example.svg)](https://crates.io/crates/rust_lib_example)
[![Docs.rs](https://img.shields.io/docsrs/rust_lib_example)](https://docs.rs/crate/rust_lib_example)
[![License](https://img.shields.io/crates/l/rust_lib_example)](https://github.com/Nicolas-Ferre/rust-example)
[![CI](https://github.com/Nicolas-Ferre/rust-example/actions/workflows/ci.yml/badge.svg)](https://github.com/Nicolas-Ferre/rust-example/actions/workflows/ci.yml)
[![Coverage with grcov](https://img.shields.io/codecov/c/gh/Nicolas-Ferre/rust-example)](https://app.codecov.io/gh/Nicolas-Ferre/rust-example)
[![Mutation tested with mutagen](https://img.shields.io/badge/mutation%20tested-mutagen-blue.svg)](https://github.com/Nicolas-Ferre/rust-example/actions/workflows/ci.yml)
[![Lines of code](https://tokei.rs/b1/github/Nicolas-Ferre/rust-example?category=code)](https://github.com/Nicolas-Ferre/rust-example)

## Purpose

This repository contains an example of Rust project structure.

Most of the components can be reusable in your own projects:
- Project configuration
- CI workflow to build, lint, test, check test coverage and run mutation tests
- CD workflow to test on all platforms and publish on [crates.io](https://crates.io)

## Github Actions workflows

### Jobs

The `CI` workflow is triggered for any commit or pull request on the `main` branch and runs the following jobs:
- Test the crate
    - Build the project for all targets and with default features to ensure everything compiles
    - Run unit, integration and doc tests with default features
- Run test coverage and mutation tests
    - Run [source-based coverage](https://marco-c.github.io/2020/11/24/rust-source-based-code-coverage.html) with [grcov](https://github.com/mozilla/grcov)
    - Upload HTML coverage report in workflow artifacts
    - Upload HTML coverage report on Codecov
    - Fail if the coverage threshold is not reached
    - Run mutation tests with [mutagen](https://github.com/llogiq/mutagen) (note that the job automatically adds `#[mutate]` annotations)
    - Fail if the mutation threshold is not reached
- Run several code checks
    - Run `clippy`
    - Run `rustfmt` to check code is correctly formatted
    - Run `cargo-deny` to check dependencies
    - Check encoding of all files is UTF-8
    - Check all line endings are LF
    - Check there is no TODO left in Rust code

This workflow is only run on Ubuntu virtual environment.

The `CD` workflow is triggered manually and runs the following jobs:
- Check version to release in `Cargo.toml` files
- Test on Ubuntu
- Test on Windows
- Test on MacOS
- Make a publication dry run on [crates.io](https://crates.io)
- Publish on [crates.io](https://crates.io)
- Create the release and prepare the next one in the repository
    - Update the latest version and its release date in the `CHANGELOG.md` file and push the changes
    - Tag the created commit with the name of the released version
    - Create a GitHub release from the created tag and the content of the `CHANGELOG.md` file
    - Create a new section for the next release in the `CHANGELOG.md` file and push the changes

### Secrets

The `CD` workflow requires the following secrets:
- `CRATES_IO_TOKEN`: token to publish the crate(s) on [crates.io](https://crates.io)
- `GIT_TOKEN`: GitHub personal access token to allow pushing changes as administrator (if the `main` branch is protected, "Include administrators" must be unchecked in settings)

These secrets must be stored in a [repository environment](https://docs.github.com/en/actions/reference/environments) called `Deployment`.

### Settings

Settings of the `CI` workflow can be modified in the file `.github/workflows/ci.yml`, in the `env` section:
- `RUST_VERSION_STABLE`: version of the stable Rust compiler to use
- `RUST_VERSION_NIGHTLY`: version of the nightly Rust compiler to use when required
- `MUTAGEN_COMMIT`: commit of the mutagen version to install ([from mutagen repository](https://github.com/llogiq/mutagen))
- `COV_THRESHOLD`: minimum threshold the coverage must reached to succeed the job
- `MUTAGEN_THRESHOLD`: minimum threshold the mutation tests must reached to succeed the job
- `CRATE_PATHS`: package names separated by `;` in publication order if the repository is a Cargo workspace, else `.`

Settings of the `CD` workflow can be modified in the file `.github/workflows/cd.yml`, in the `env` section:
- `RUST_VERSION_STABLE`: version of the stable Rust compiler to use
- `CRATE_PATHS`: package names separated by `;` in publication order if the repository is a Cargo workspace, else `.`

### Run locally

[act](https://github.com/nektos/act) can be used to run the workflows on your own machine.<br>
Once installed, run `act -P ubuntu-18.04=nektos/act-environments-ubuntu:18.04` in the repository folder to run all supported jobs.

### Workspaces

This repository contains a single crate, but the workflows should also work with a Cargo workspace.

## Adaptations for another project

This project example is made to be reused.
If you are interested in using this template, you can copy the files in your own project and:
- adapt the settings of the CI workflow in the file `.github/workflows/ci.yml`, in the `env` section
- adapt the settings of the CD workflow in the file `.github/workflows/cd.yml`, in the `env` section
- edit the `.lints`, `deny.toml`, `rustfmt.toml`, `Cargo.toml` and `README.md` files as wanted
- edit the issue templates in `.github/ISSUE_TEMPLATE` as wanted
- reset the `CHANGELOG.md` file (make sure there is at least a section `## [Unreleased] - yyyy-mm-dd`)
- change the copyright notices in the `LICENSE-MIT` and `LICENSE-APACHE` files if you keep these licenses
- in the repository settings, create a GitHub environment named `Deployment` with the `CRATES_IO_TOKEN` and `GIT_TOKEN` secrets
- if the `main` branch is configured as protected, make sure `Include administrators` is unchecked in the configuration

## License

Licensed under either of

 * Apache License, Version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
 * MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)

at your option.

### Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall be dual licensed as above, without any
additional terms or conditions.
