# Disk images

- `install` - ISO CD / DVD installers for e.g. Debian, Ubuntu, other 
distros
- `test` - QCOW2 or other HDD images for cattle test VMs that have never 
seen Firezone before and are ready for a clean install.

These files are too big to reasonably store in Git, so the images are 
blocked by `.gitignore` and only the `*.sha256sum.txt` files are checked 
in.

`b3sum` sums are provided because BLAKE3 is faster than SHA256 and it's noticeable on large files and slow CPUs.

- [Debian version table](https://en.wikipedia.org/wiki/Debian_version_history#Release_table)
- [Ubuntu version table](https://en.wikipedia.org/wiki/Ubuntu_version_history#Table_of_versions)
