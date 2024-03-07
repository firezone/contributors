# Disk images

To boot a test VM, run `./run_before_firezone.sh machines/$MACHINE_NAME`

## Building a test VM

1. Write the `lib.sh` file with the `INSTALL_ISO` and a `NAME` matching the dir name
1. `./install_machine.sh machines/$MACHINE_NAME`
1. `./update_before_firezone.sh machines/$MACHINE_NAME`
1. `./update_hashes.sh machines/$MACHINE_NAME`

To rebuild the "Before Firezone" overlay without re-installing the entire OS,
run the steps again starting from `./update_before_firezone.sh`

## Details

- `common` - Bash script components, not for human use
- `install` - ISO CD / DVD installers for e.g. Debian, Ubuntu, other 
distros
- `machines` - QCOW2 or other HDD images for cattle test VMs that have never 
seen Firezone before and are ready for a clean install.

The images are too big to reasonably store in Git, so they're are 
blocked by `.gitignore` and the hashes are checked in instead.

The EFI vars are 64 MB on disk but gzip down to 67 KB, so they're probably almost all zeroes. These are checked in to Git.

`b3sum` sums are provided because BLAKE3 is faster than SHA256 and it's noticeable on large files or slow CPUs.

- [Debian version table](https://en.wikipedia.org/wiki/Debian_version_history#Release_table)
- [Ubuntu version table](https://en.wikipedia.org/wiki/Ubuntu_version_history#Table_of_versions)
