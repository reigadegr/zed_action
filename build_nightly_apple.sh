#!/bin/bash

export RUSTFLAGS="
    -Z mir-opt-level=2
    -Z dylib-lto=yes
    -Z inline-mir=yes
    -Z fewer-names=yes
    -Z share-generics=yes
    -Z remap-cwd-prefix=.
    -Z no-leak-check
    -Z strict-init-checks=no
    -Z randomize-layout=no
    -Z extra-const-ub-checks=no
    -Z function-sections=yes
    -Z dep-info-omit-d-target
    -Z flatten-format-args=yes
    -Z saturating-float-casts=yes
    -Z mir-enable-passes=+Inline
    -Z precise-enum-drop-elaboration=yes
    -C relro-level=none
    -C code-model=small
    -C linker-plugin-lto=no
    -C relocation-model=static
    -C symbol-mangling-version=v0
" 

cargo update

export CARGO_TERM_COLOR=always

export JEMALLOC_SYS_DISABLE_WARN_ERROR=1

cargo +nightly build -r --target "$1" --bin "$2" -Z trim-paths --features mimalloc
