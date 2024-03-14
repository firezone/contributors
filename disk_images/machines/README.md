# `disk_images/machines`

Pre-installed copies of Debian, Ubuntu, etc. that have a non-admin user
with sudo and only the base packages. They've never seen Firezone before,
so they can simulate first-time installs.

Log in with `user` and `password`. SSH is port 22 in the guest, forwarded to port 2222 on the host by default, override with `SSH_FWD_PORT`

Ubuntu doesn't publish official aarch64 desktop images, so the Ubuntus are
Ubuntu Server with `sudo apt-get install ubuntu-desktop`.

Debian with KDE is available at ReactorScram's personal preference.

The "before-firezone" images are overlays atop "before-first-boot".
So if you update the "before-first-boot" image, e.g. by re-running `install_machine.sh`, you will need to rebuild the "before-firezone" overlay by deleting it and running `update_before_firezone.sh`

Try `./run_before_firezone.sh machines/ubuntu-22.04.4-arm64`

To create an overlay image without modifying the original:

```bash
qemu-img create \
-b before-first-boot.qcow2 \
-F qcow2 \
-f qcow2 \
before-something.qcow 100G
```
