#!/usr/bin/env bash

ZIG="$1"
ROOT_DIR="$(pwd)"
echo $ROOT_DIR
echo $ZIG
if [[ -z "$ZIG" ]]; then
  echo "$ROOT_DIR/solana-zig/zig"
  ZIG="$ROOT_DIR/solana-zig/zig"
fi

set -e
$ZIG build --summary all --verbose
SBF_OUT_DIR="$ROOT_DIR/zig-out/lib" cargo test --manifest-path "$ROOT_DIR/Cargo.toml"