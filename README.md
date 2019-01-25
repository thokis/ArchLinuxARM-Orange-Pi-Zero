# ArchLinuxARM-Orange-Pi-Zero

This image was created with the following guide : https://wiki.archlinux.org/index.php/Orange_Pi.

WiFi doesn't work, but to be honest this isn't a issue at all for me. 
The driver from Allwinner is unbelivable garbage and quite ununsable on mainline kernel. Wired connection is the way to go.

I preconfigured U-boot with the sun8i-h3-analog-codec overlay because i wanted an low-energy and small bluetooth/librespot reciver.
Of course you can change it to any overlay Allwinner provides, but I only tested the previously mentioned.

Also uart is enabled with an baudrate of 115200.

## Preparation

Obviously you need an SD (min. 2GB), uboot-tools, fdisk, wget, git and some time. I promise it wont take long.

## Install

###### STEP ZERO

As always clone this repository and cd into it.

```
git clone https://github.com/thokis/ArchLinuxARM-Orange-Pi-Zero.git archlinuxarm_orangepizero
cd archlinuxarm_orangepizero
wget https://github.com/thokis/ArchLinuxARM-Orange-Pi-Zero/releases/download/1.0/ArchLinuxARM-orangepizero.tar.gz
```

###### STEP ONE

Partition your SD. Get your SD dev name with `lsblk`. Now become root with `sudo su`. After that you launch `fdisk /dev/sdX`.
In fdisk you need to create a new partition layout with typing `o` and pressing `Enter`. Now you create a new partition by doing the same, only with `n` and 5x pressing `Enter`. Now you type `w` and press `Enter` for the last time and et voilà you have partitioned your SD.

###### STEP TWO

Creating a filesystem on your freshly partitioned SD and mounting it. Very easy. Run `mkfs.ext4 /dev/sdX1` and wait a little bit. But it shouldn't take to long. Now run `mount /dev/sdX1 root` and we are ready for step three.

###### STEP THREE

Now we will extract the ArchLinuxARM-orangepizero.tar.gz onto the mounted SD. It contains the rootfs but no bootloader. More about that when we hit step four. Extracting, as you might guessed it, is again very easy. Simply run `tar -xpf ArchLinuxARM-orangepizero.tar.gz -C root`. To be honest this might take a while, depending on your SD speed class and/or brand. Anyway, after this little coffe break unmount your SD with `umount root`. We are now on the final stretch.

###### STEP FOUR

Now we need to write the U-boot image onto the SD. Run `dd if=u-boot-sunxi-with-spl.bin of=/dev/sdX bs=1024 seek=8`. If it doesn't spit out a error message I congratulate you. You are officially ready to stick that SD into your Orange Pi Zero and feeling proud. You are really the man ... or women if thats the case.

## Some usefull resources

http://irq5.io/2018/07/24/boot-time-device-tree-overlays-with-u-boot/
https://i0.wp.com/oshlab.com/wp-content/uploads/2016/11/Orange-Pi-Zero-Pinout-banner2.jpg?fit=1200%2C628&ssl=1
http://esp8266-server.de/OrangePi/dateien/Audio.png
