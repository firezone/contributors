#!/usr/bin/env bash
# Usage: ./update_before_firezone.sh machines/debian-12.5.0-arm64


set -euo pipefail

DIR="$1"

. "$DIR/lib.sh"

HDD_BF="$DIR/before-firezone.qcow2"

QEMU_ARGS=(
    "${QEMU_ARGS[@]}"

    # For updates, allow lots of CPU and RAM
    "-smp" "cpus=8,sockets=1,cores=8,threads=1"
    "-m" "8192"

    # Allow EFI vars to change whenever the HDD image is allowed to change
    "-drive" "if=pflash,unit=1,format=raw,file=$EFI_VARS_BFB,readonly=off"

    "-hda" "$HDD_BF"
)

if [ ! -f "$HDD_BF" ]; then
    echo "$HDD_BFB"
    echo "$HDD_BF"
    qemu-img create -b "before-first-boot.qcow2" -F qcow2 -f qcow2 "$HDD_BF" 100G
fi

date -u
b3sum "$EFI_VARS_BFB"
qemu-system-aarch64 "${QEMU_ARGS[@]}"
b3sum "$EFI_VARS_BFB"
