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
    -C default-linker-libraries
    -C relocation-model=pic
    -C symbol-mangling-version=v0
    -C llvm-args=-fp-contract=off
    -C llvm-args=-enable-misched
    -C llvm-args=-enable-post-misched
    -C llvm-args=-enable-dfa-jump-thread
    -C link-args=-Wl,--sort-section=alignment
    -C link-args=-Wl,-O2,--gc-sections,--as-needed
    -C link-args=-Wl,-x,-z,noexecstack,-s,--strip-all
" 

export RUSTFLAGS="
    $RUSTFLAGS
    --cfg tokio_unstable
"

echo $RUSTFLAGS

# cargo update

export CARGO_TERM_COLOR=always

export JEMALLOC_SYS_DISABLE_WARN_ERROR=1

cargo +nightly build -r --target "$1" -Z trim-paths -Z build-std=core,alloc,std,panic_abort --all-features
