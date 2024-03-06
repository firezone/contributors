#!/usr/bin/env bash
set -euo pipefail

NAME="debian-12.5.0-arm64"
QEMU_PREFIX="/opt/homebrew/Cellar/qemu/8.2.1/share/qemu/"

args=(
    "-name" "$NAME"
    # TODO: May be redundant
    "-L" "$QEMU_PREFIX"
    # Provides "usb-bus.0" that other USB devices use
    "-device" "nec-usb-xhci,id=usb-bus"
    "-device" "virtio-balloon-pci"
    "-device" "virtio-gpu-pci"
    "-device" "virtio-rng-pci"
    "-device" "usb-kbd,bus=usb-bus.0"
    "-cpu" "host"
    # During install, give the VM lots of resources to complete the install quickly
    # For performance tests, we may shrink the resources
    "-smp" "cpus=8,sockets=1,cores=8,threads=1"
    "-m" "8192"
    "-machine" "virt"
    # Will have to generalize this for non-macOS
    "-accel" "hvf"
    # Must be a BIOS or something?
    "-drive" "if=pflash,format=raw,unit=0,file.filename=$QEMU_PREFIX/edk2-aarch64-code.fd,file.locking=off,readonly=on"
    "-cdrom" "install/debian-12.5.0-arm64-netinst.iso"
)

qemu-system-aarch64 "${args[@]}"