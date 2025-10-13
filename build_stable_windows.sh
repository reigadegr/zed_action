#!/bin/bash

export RUSTFLAGS="
    -C relro-level=none
    -C code-model=small
    -C linker-plugin-lto=no
    -C default-linker-libraries
    -C target-cpu=native
    -C target-feature=+crt-static
    -C symbol-mangling-version=v0
" 

export RUSTFLAGS+="
    --cfg tokio_unstable
    --cfg windows_slim_errors
"

# cargo update

export CARGO_TERM_COLOR=always

export JEMALLOC_SYS_DISABLE_WARN_ERROR=1

cargo +stable build -r --target "$1" --all-features
