# `disk_images/test`

Pre-installed copies of Debian, Ubuntu, etc. that have a non-admin user
with sudo and only the base packages. They've never seen Firezone before,
so they can simulate first-time installs.

To create an overlay image without modifying the original:

```bash
qemu-img create \
-b before-first-boot.qcow2 \
-F qcow2 \
-f qcow2 \
before-something.qcow 100G
```
