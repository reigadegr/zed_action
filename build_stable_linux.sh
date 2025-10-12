#!/bin/bash

export RUSTFLAGS="
    -C relro-level=none
    -C code-model=small
    -C linker-plugin-lto=no
    -C default-linker-libraries
    -C relocation-model=static
    -C symbol-mangling-version=v0
    -C llvm-args=-fp-contract=off
    -C llvm-args=-enable-misched
    -C llvm-args=-enable-post-misched
    -C llvm-args=-enable-dfa-jump-thread
    -C link-args=-Wl,--sort-section=alignment
    -C link-args=-Wl,-O2,--gc-sections,--as-needed
    -C link-args=-Wl,-x,-z,noexecstack,-s,--strip-all
"

cargo update

export CARGO_TERM_COLOR=always

export JEMALLOC_SYS_DISABLE_WARN_ERROR=1

cargo +stable zigbuild -r --target "$1" --bin "$2" --all-features
