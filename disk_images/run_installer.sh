#!/usr/bin/env bash
# Usage: ./run_installer.sh test/debian-12.5.0-arm64
# Creates the "before first boot" HDD image and runs the installer ISO

set -euo pipefail

DIR="$1"

. "$DIR/lib.sh"

QEMU_ARGS=(
    "${QEMU_ARGS[@]}"

    # During install, give the VM lots of resources to complete the install quickly
    # For performance tests, we may shrink the resources
    "-smp" "cpus=8,sockets=1,cores=8,threads=1"
    "-m" "8192"

    # EFI vars are writable during install
    "-drive" "if=pflash,unit=1,format=raw,file=$EFI_VARS_BFB,readonly=off"

    "-cdrom" "$INSTALL_ISO"
    "-hda" "$HDD_BFB"
)

if [ ! -f "$HDD_BFB" ]; then
    qemu-img create -f qcow2 "$HDD_BFB" 100G
fi

cp "$EFI_VARS_SRC" "$EFI_VARS_BFB"
qemu-system-aarch64 "${QEMU_ARGS[@]}"
