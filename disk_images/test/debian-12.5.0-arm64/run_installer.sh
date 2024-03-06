#!/usr/bin/env bash
set -euo pipefail

NAME="debian-12.5.0-arm64"
QEMU_PREFIX="/opt/homebrew/Cellar/qemu/8.2.1/share/qemu/"

qemu-system-aarch64 \
-L "$QEMU_PREFIX" \
-device virtio-gpu-pci \
-cpu host \
-smp cpus=8,sockets=1,cores=8,threads=1 \
-machine virt \
-accel hvf \
-drive if=pflash,format=raw,unit=0,file.filename="$QEMU_PREFIX"/edk2-aarch64-code.fd,file.locking=off,readonly=on \
-m 8192 \
-cdrom install/debian-12.5.0-arm64-netinst.iso \
-name "$NAME" \
-device virtio-rng-pci \
-device virtio-balloon-pci