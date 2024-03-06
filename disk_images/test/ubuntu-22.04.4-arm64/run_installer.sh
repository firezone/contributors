#!/usr/bin/env bash
# Usage: test/release_name/run_installer.sh
# Creates the "before first boot" HDD image and runs the installer ISO

set -euo pipefail

. test/ubuntu-22.04.4-arm64/lib.sh
. test/install/lib.sh

if [ ! -f "$HDD_BFB" ]; then
    qemu-img create -f qcow2 "$HDD_BFB" 100G
fi

cp "$EFI_VARS_SRC" "$EFI_VARS_BFB"
qemu-system-aarch64 "${QEMU_ARGS[@]}"
