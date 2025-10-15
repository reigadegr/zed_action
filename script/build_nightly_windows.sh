#!/bin/bash

export RUSTFLAGS="
    -Z mir-opt-level=2
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
    -C target-cpu=native
    -C force-frame-pointers=no
    -C target-feature=+crt-static
    -C symbol-mangling-version=v0
" 

if [ ! -z "$(echo "$1" | grep "aarch64")" ]; then
    export RUSTFLAGS="$RUSTFLAGS -C target-feature=-fullfp16"
fi

export RUSTFLAGS="
    $RUSTFLAGS
    --cfg tokio_unstable
    --cfg windows_slim_errors
"

echo $RUSTFLAGS
# cargo update

export CARGO_TERM_COLOR=always

export JEMALLOC_SYS_DISABLE_WARN_ERROR=1

cargo +nightly build -r --target "$1" -Z trim-paths -Z build-std=core,alloc,std,panic_abort --all-features
