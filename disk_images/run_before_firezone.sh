#!/usr/bin/env bash
# Usage: ./run_before_firezone.sh machines/debian-12.5.0-arm64
# 
# Non-destructive run of the "Before Firezone" image. For each machine this image
# is an overlay on "Before First Boot". It will have some desktop environment installed.
# This script uses `-snapshot`, so the QCOW2 image will not be changed.

set -euo pipefail

DIR="$1"

. "$DIR/lib.sh"

EFI_VARS_TEMP="$DIR/efi_vars_temp.fd"
HDD_BF="$DIR/before-firezone.qcow2"

QEMU_ARGS=(
    "${QEMU_ARGS[@]}"

    # For tests, restrict the CPU and RAM
    "-smp" "cpus=1,sockets=1,cores=1,threads=1"
    "-m" "2048"

    # For normal use, use a writable copy of the before-first-boot EFI vars
    "-drive" "if=pflash,unit=1,file=$EFI_VARS_TEMP,readonly=off"

    "-hda" "$HDD_BF"
    "-snapshot"

    # Shared folder
    "-fsdev" "local,id=virtfs0,path=share,security_model=mapped-xattr"
    "-device" "virtio-9p-pci,fsdev=virtfs0,mount_tag=share"
)

# The EFI vars must be writable. We don't want those trashed, so copy them.
cp "$EFI_VARS_BFB" "$EFI_VARS_TEMP"

qemu-system-aarch64 "${QEMU_ARGS[@]}"
rm "$EFI_VARS_TEMP"
