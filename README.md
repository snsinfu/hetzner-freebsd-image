## Create an image

Set `HCLOUD_TOKEN` environment variable and type `make` to start a base image
server. Go to the Hetzner cloud console and open the VNC console. FreeBSD
installation starts. Proceed as follows:

1. Continue with default keymap
2. Set no hostname
3. Distribution: Uncheck all optional components
4. Setup IPv4 network with DHCP
5. Choose mirror: `ftp://ftp.de.freebsd.org`
6. Partitioning: Auto (UFS)
7. Select GPT
8. Edit partition table:
   ```
   da0
     da0p1  512KB   freebsd-boot
     da0p2  2GB     freebsd-swap    none
     da0p3  17GB    freebsd-ufs     /
   ```
9. Commit
10. Password: Set empty
11. Time Zone: UTC
12. Time & Date: Skip
13. System Configuration: OK
14. System Hardening: OK
15. Add User Accounts: No
16. Exit
17. Manual Configuration (shell): Yes
    ```
    fetch -o- http://169.254.169.254/latest/user-data | sh
    ```

Now the base image is created. Go to the web console, **power off** the server
and **unmount ISO**. Then, take a snapshot and attach a label: `custom_image:
freebsd-12.1`.


## Use image in Terraform configuration

```
resource "hcloud_server" "master" {
  image     = data.hcloud_image.freebsd.id
  user_data = "shell script"
}

data "hcloud_image" "freebsd" {
  with_selector = "custom_image=freebsd-12.1"
}
```
