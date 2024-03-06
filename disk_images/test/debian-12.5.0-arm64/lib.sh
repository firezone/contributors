#!/usr/bin/env bash

NAME="debian-12.5.0-arm64"
DIR="test/$NAME"
INSTALL_ISO="install/debian-12.5.0-arm64-netinst.iso"
HDD_BFB="$DIR/before-first-boot.qcow2"
QEMU_PREFIX="/opt/homebrew/Cellar/qemu/8.2.1/share/qemu"

EFI_CODE="$QEMU_PREFIX/edk2-aarch64-code.fd"
EFI_VARS_SRC="$QEMU_PREFIX/edk2-arm-vars.fd"
EFI_VARS_BFB="$DIR/efi_vars_bfb.fd"

QEMU_ARGS=(
    "-name" "$NAME"
    # TODO: May be redundant
    "-L" "$QEMU_PREFIX"

    # Stuff that tells qemu to go fast and use a default machine
    #   Will have to generalize this for non-macOS
    "-accel" "hvf"
    "-cpu" "host"
    "-machine" "virt-8.2"

    # UEFI ROM
    "-drive" "if=pflash,format=raw,unit=0,file.filename=$EFI_CODE,file.locking=off,readonly=on"

    # I/O
    #   Provides "usb-bus.0" that other USB devices use
    "-device" "nec-usb-xhci,id=usb-bus"
    "-device" "usb-kbd,bus=usb-bus.0"
    "-device" "usb-mouse,bus=usb-bus.0"
    "-device" "usb-tablet,bus=usb-bus.0"
    "-device" "virtio-balloon-pci"
    "-device" "virtio-gpu-pci"
    "-device" "virtio-rng-pci"
    #   Shows a default mouse cursor
    "-display" "cocoa,show-cursor=on"
)
