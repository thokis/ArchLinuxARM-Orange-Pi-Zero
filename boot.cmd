part uuid ${devtype} ${devnum}:${bootpart} uuid
setenv bootargs console=ttyS0,115200 root=PARTUUID=${uuid} rw rootwait
setenv verbosity "1"

if load ${devtype} ${devnum}:${bootpart} ${kernel_addr_r} /boot/zImage; then
	if load ${devtype} ${devnum}:${bootpart} ${fdt_addr_r} /boot/dtbs/${fdtfile}; then			
		fdt addr ${fdt_addr_r}
		fdt resize
		setexpr fdtovaddr ${fdt_addr_r} + F000
		echo "Loading Overlay"
		load ${devtype} ${devnum}:${bootpart} ${fdtovaddr} /boot/dtbs/overlay/sun8i-h3-analog-codec.dtbo && fdt apply ${fdtovaddr}
		if load ${devtype} ${devnum}:${bootpart} ${ramdisk_addr_r} /boot/initramfs-linux.img; then
			bootz ${kernel_addr_r} ${ramdisk_addr_r}:${filesize} ${fdt_addr_r};
		else
			bootz ${kernel_addr_r} - ${fdt_addr_r};
		fi;
	fi;
fi

if load ${devtype} ${devnum}:${bootpart} 0x48000000 /boot/uImage; then
	if load ${devtype} ${devnum}:${bootpart} 0x43000000 /boot/script.bin; then
		setenv bootm_boot_mode sec;
		bootm 0x48000000;
	fi;
fi
