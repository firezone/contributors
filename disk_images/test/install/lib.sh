QEMU_ARGS=(
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
