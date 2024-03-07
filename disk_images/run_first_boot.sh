#!/usr/bin/env bash
# Runs the "before first boot" HDD with `-snapshot` so the file won't be changed.

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
qemu-system-aarch64 "${QEMU_ARGS[@]}"
rm "$EFI_VARS_TEMP"
