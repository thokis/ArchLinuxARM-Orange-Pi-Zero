# ArchLinuxARM-Orange-Pi-Zero

This image was created with the following guide : https://wiki.archlinux.org/index.php/Orange_Pi.

WiFi doesn't work.

Preconfigured U-boot with the sun8i-h3-analog-codec.dtbo

UART is enabled with an baudrate of 115200.

## Preparation

You need an microSD, uboot-tools, fdisk, wget, git and some time.

## Install

###### STEP ZERO

Clone this repository and cd into it. Also download the tar.gz archive and become root.

```
git clone https://github.com/thokis/ArchLinuxARM-Orange-Pi-Zero.git orangepizero
cd orangepizero
mkdir root
wget http://os.archlinuxarm.org/os/ArchLinuxARM-armv7-latest.tar.gz
sudo su
```

###### STEP ONE

Partition the microSD. Launch `fdisk /dev/sdX`. Create a new partition layout by typing `o` and pressing `Enter`. Type in `n` and pressing `Enter` 5x to create a partition. Save the layout by typing `w` and press `Enter`.

###### STEP TWO

Create a filesystem and mount it. Run `mkfs.ext4 /dev/sdX1` and wait until it is finished. Now run `mount /dev/sdX1 root`.

###### STEP THREE

Extract the rootfs onto the filesystem. Run `bsdtar -xvpf ArchLinuxARM-armv7-latest.tar.gz -C root`. This might take a while, depending on the microSD speed class and/or brand. 

Copy boot directory to root with `cp -r boot/* root/boot/`. Unmount your SD with `umount root`.

###### FINAL STEP

Write the U-boot image. Run `dd if=u-boot-sunxi-with-spl.bin of=/dev/sdX bs=1024 seek=8`.

## Some usefull resources

http://irq5.io/2018/07/24/boot-time-device-tree-overlays-with-u-boot/

https://i0.wp.com/oshlab.com/wp-content/uploads/2016/11/Orange-Pi-Zero-Pinout-banner2.jpg?fit=1200%2C628&ssl=1

http://esp8266-server.de/OrangePi/dateien/Audio.png
