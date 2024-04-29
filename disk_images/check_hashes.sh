#!/usr/bin/env bash
# Usage ./check_hashes.sh machines/debian-12.5.0-arm64

set -euo pipefail

DIR="$1"

pushd "$DIR" > /dev/null

files=(
    "before-first-boot.qcow2"
    "before-firezone.qcow2"
)

for file in "${files[@]}"
do
    # 5x faster than SHA256 on the M2 chip
    b3sum -c "$file.b3sum.txt"
    # sha256sum -c "$file.sha256sum.txt"
done

popd > /dev/null
