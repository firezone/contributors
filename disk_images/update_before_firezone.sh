#!/usr/bin/env bash
# Usage: ./update_before_firezone.sh test/debian-12.5.0-arm64
# Uses the "Before first boot" image as a base to create a "Before Firezone" overlay

set -euo pipefail

DIR="$1"

. "$DIR/lib.sh"

EFI_VARS_TEMP="$DIR/efi_vars_temp.fd"
HDD_BF="$DIR/before-firezone.qcow2"

QEMU_ARGS=(
    "${QEMU_ARGS[@]}"

    # For updates, allow lots of CPU and RAM
    "-smp" "cpus=8,sockets=1,cores=8,threads=1"
    "-m" "8192"

    # Use a temp copy of EFI vars since we shouldn't be changing the boot loader
    "-drive" "if=pflash,unit=1,file=$EFI_VARS_TEMP,readonly=off"

    "-hda" "$HDD_BF"
)

# The EFI vars must be writable for the VM to boot. 
# We don't want those trashed, so copy them.
cp "$EFI_VARS_BFB" "$EFI_VARS_TEMP"

if [ ! -f "$HDD_BF" ]; then
    env | sort
    qemu-img create -b "$HDD_BFB" -F qcow2 -f qcow2 "$HDD_BF" 100G
fi

qemu-system-aarch64 "${QEMU_ARGS[@]}"
rm "$EFI_VARS_TEMP"
