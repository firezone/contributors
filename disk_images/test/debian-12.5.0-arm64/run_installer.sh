#!/usr/bin/env bash
# Usage: test/release_name/run_installer.sh
# Creates the "before first boot" HDD image and runs the installer ISO

set -euo pipefail

. test/debian-12.5.0-arm64/lib.sh

if [ ! -f "$HDD_BFB" ]; then
    qemu-img create -f qcow2 "$HDD_BFB" 100G
fi

cp "$EFI_VARS_SRC" "$EFI_VARS_BFB"

args=(
    "${QEMU_ARGS[@]}"

    # During install, give the VM lots of resources to complete the install quickly
    # For performance tests, we may shrink the resources
    "-smp" "cpus=8,sockets=1,cores=8,threads=1"
    "-m" "8192"

    # EFI vars are writable during install
    "-drive" "if=pflash,unit=1,file=$EFI_VARS_BFB,readonly=off"

    "-cdrom" "$INSTALL_ISO"
    "-hda" "$HDD_BFB"
)

qemu-system-aarch64 "${args[@]}"