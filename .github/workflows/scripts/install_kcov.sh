#!/bin/bash
set -xeu

sudo apt-get update
sudo apt-get install zlib1g-dev libelf-dev libcurl4-openssl-dev libdw-dev libbfd-dev libiberty-dev
wget https://github.com/SimonKagstrom/kcov/archive/"$KCOV_VERSION".tar.gz
tar xzf "$KCOV_VERSION".tar.gz
cd kcov-"$KCOV_VERSION"
mkdir build
cd build
cmake ..
make
sudo make install
