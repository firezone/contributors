EFI_VARS_TEMP="$DIR/efi_vars_temp.fd"

QEMU_ARGS=(
    "${QEMU_ARGS[@]}"

    # For testing, use lower resources to shake out performance problems in Firezone
    "-smp" "cpus=2,sockets=1,cores=2,threads=1"
    "-m" "2048"

    # For normal use, use a writable copy of the before-first-boot EFI vars
    "-drive" "if=pflash,unit=1,file=$EFI_VARS_TEMP,readonly=off"

    "-hda" "$HDD_BFB"
    "-snapshot"
)
