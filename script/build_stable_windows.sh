#!/bin/bash

export RUSTFLAGS="
    -C relro-level=none
    -C code-model=small
    -C target-cpu=native
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

cargo +stable build -r --target "$1" --all-features
