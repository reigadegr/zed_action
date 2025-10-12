#!/bin/bash

export RUSTFLAGS="
    -C relro-level=none
    -C code-model=small
    -C linker-plugin-lto=no
    -C default-linker-libraries
    -C relocation-model=static
    -C symbol-mangling-version=v0
"

cargo update

export CARGO_TERM_COLOR=always

export JEMALLOC_SYS_DISABLE_WARN_ERROR=1

cargo +stable zigbuild -r --target "$1" --bin "$2" --features mimalloc
