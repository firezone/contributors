#!/usr/bin/env bash
# Usage: ./update_hashes.sh test/debian-12.5.0-arm64

set -euo pipefail

DIR="$1"

pushd "$DIR"

files=(
    "before-first-boot.qcow2"
    "before-firezone.qcow2"
)

for file in "${files[@]}"
do
    # 5x faster than SHA256 on the M2 chip
    b3sum "$file" > "$file.b3sum.txt"
    sha256sum "$file" > "$file.sha256sum.txt"
done

popd
