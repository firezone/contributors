#!/usr/bin/env bash
# Runs the "before first boot" HDD image to create "before Firezone"

set -euo pipefail

. test/ubuntu-22.04.4-arm64/lib.sh

EFI_VARS_TEMP="$DIR/efi_vars_temp.fd"
HDD_BF="$DIR/before-firezone.qcow2"

QEMU_ARGS=(
    "${QEMU_ARGS[@]}"

    # For updates, allow lots of CPU and RAM
    "-smp" "cpus=8,sockets=1,cores=8,threads=1"
    "-m" "8192"

    # For normal use, use a writable copy of the before-first-boot EFI vars
    "-drive" "if=pflash,unit=1,file=$EFI_VARS_TEMP,readonly=off"

    "-hda" "$HDD_BF"
)

# The EFI vars must be writable. We don't want those trashed, so copy them.
cp "$EFI_VARS_BFB" "$EFI_VARS_TEMP"

if [ ! -f "$HDD_BF" ]; then
    qemu-img create -b "$HDD_BFB" -F qcow2 -f qcow2 "$HDD_BF" 100G
fi

qemu-system-aarch64 "${QEMU_ARGS[@]}"
