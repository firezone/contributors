#!/usr/bin/env bash
# Usage: ./run_first_boot.sh machines/debian-12.5.0-arm64
#
# Non-destructive run of the "Before First Boot" image. This is a standalone QCOW2
# frozen after the VM has installed Linux and been shut down. It may not have a
# desktop environment.
# This script uses `-snapshot`, so the QCOW2 image will not be changed.

set -euo pipefail

DIR="$1"

. "$DIR/lib.sh"

EFI_VARS_TEMP="$DIR/efi_vars_temp.fd"

QEMU_ARGS=(
    "${QEMU_ARGS[@]}"

    # For testing, use lower resources to shake out performance problems in Firezone
    "-smp" "cpus=2,sockets=1,cores=2,threads=1"
    "-m" "2048"

    # For normal use, use a writable copy of the before-first-boot EFI vars
    "-drive" "if=pflash,unit=1,format=raw,file=$EFI_VARS_TEMP,readonly=off"

    "-hda" "$HDD_BFB"
    "-snapshot"
)

# The EFI vars must be writable. We don't want those trashed, so copy them.
cp "$EFI_VARS_BFB" "$EFI_VARS_TEMP"

echo "${QEMU_ARGS[@]}"
qemu-system-aarch64 "${QEMU_ARGS[@]}"
rm "$EFI_VARS_TEMP"
