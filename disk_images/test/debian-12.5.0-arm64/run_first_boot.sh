#!/usr/bin/env bash
# Runs the "before first boot" HDD image with `-snapshot` so that the file won't be
# changed by accident.

set -euo pipefail

. test/debian-12.5.0-arm64/lib.sh

# It seems the EFI vars must be writable. We don't want those trashed, so copy them.
EFI_VARS_TEMP="$DIR/efi_vars_temp.fd"
cp "$EFI_VARS_BFB" "$EFI_VARS_TEMP"

args=(
    "${QEMU_ARGS[@]}"

    # For testing, use lower resources to shake out performance problems in Firezone
    "-smp" "cpus=2,sockets=1,cores=2,threads=1"
    "-m" "2048"

    # For normal use, use a writable copy of the before-first-boot EFI vars
    "-drive" "if=pflash,unit=1,file=$EFI_VARS_TEMP,readonly=off"

    "-hda" "$HDD_BFB"

    "-snapshot"
)

qemu-system-aarch64 "${args[@]}"