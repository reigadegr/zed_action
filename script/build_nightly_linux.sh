#!/bin/bash

export RUSTFLAGS="
    -Z mir-opt-level=2
    -Z dylib-lto=yes
    -Z share-generics=yes
    -Z remap-cwd-prefix=.
    -Z randomize-layout=no
    -Z function-sections=yes
    -Z dep-info-omit-d-target
    -Z flatten-format-args=yes
    -Z saturating-float-casts=yes
    -Z precise-enum-drop-elaboration=yes
    -C relro-level=none
    -C code-model=small
    -C default-linker-libraries
    -C relocation-model=pic
    -C symbol-mangling-version=v0
    -C link-arg=-fuse-ld=mold
    -C llvm-args=-fp-contract=off
    -C llvm-args=-enable-misched
    -C llvm-args=-enable-post-misched
    -C llvm-args=-enable-dfa-jump-thread
    -C link-args=-Wl,--sort-section=alignment
    -C link-args=-Wl,-O3,--gc-sections,--as-needed
    -C link-args=-Wl,-x,-z,noexecstack,-s,--strip-all,--relax
" 

export RUSTFLAGS="
    $RUSTFLAGS
    --cfg tokio_unstable
"

echo $RUSTFLAGS

# cargo update

export CARGO_TERM_COLOR=always

export JEMALLOC_SYS_DISABLE_WARN_ERROR=1

cargo +nightly build -r --target "$1" -Z build-std=core,alloc,std,panic_abort --all-features
