#!/usr/bin/env bash
# Runs the "before first boot" HDD image with `-snapshot` so that the file won't be
# changed by accident.

set -euo pipefail

. test/debian-12.5.0-arm64/lib.sh
. test/first_boot/lib.sh

# The EFI vars must be writable. We don't want those trashed, so copy them.
cp "$EFI_VARS_BFB" "$EFI_VARS_TEMP"

qemu-system-aarch64 "${QEMU_ARGS[@]}"
