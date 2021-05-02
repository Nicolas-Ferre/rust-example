# Changelog

## [Unreleased] - yyyy-mm-dd

## [0.2.0] - 2021-05-02

### Added

- Version and date update in `CHANGELOG.md` file by the CD pipeline
- Creation of new section for the next version in `CHANGELOG.md` file by the CD pipeline
- Version incrementing in `Cargo.toml` files by the CD pipeline

### Modified

- Work in progress branch (`main` instead of `develop`)
- Events that trigger CI and CD pipelines
- Version detection in CD pipeline (look at `Cargo.toml` files instead of `CHANGELOG.md`)
- Parallelization of CI and CD pipelines

### Deleted

- Support of `develop` branch

## [0.1.0] - 2021-04-14

### Added

- Example of Rust project structure
- CI pipeline to build, lint and test a project
- CD pipeline to publish on [crates.io](https://crates.io)
