#!/bin/bash

export RUSTFLAGS="
    -C relro-level=none
    -C code-model=small
    -C linker-plugin-lto=no
    -C relocation-model=static
    -C symbol-mangling-version=v0
" 

cargo update

export CARGO_TERM_COLOR=always

export JEMALLOC_SYS_DISABLE_WARN_ERROR=1

cargo +stable build -r --target "$1" --bin "$2" --all-features
