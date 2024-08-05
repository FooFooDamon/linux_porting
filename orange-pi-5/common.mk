ARCH ?= arm64
CROSS_COMPILE ?= aarch64-linux-gnu-
KERNEL_IMAGE ?= Image
DTS_PATH ?= arch/${ARCH}/boot/dts/rockchip/rk3588s-orangepi-5.dts
INSTALL_DIR ?= $(if $(filter aarch64, $(shell uname -m)), /boot, ${HOME}/tftpd/orange-pi-5)
DEFCONFIG ?= arch/${ARCH}/configs/rockchip_linux_defconfig
EXT_TARGETS +=
CUSTOM_FILES += arch/${ARCH}/boot/dts/rockchip/Makefile \
    arch/${ARCH}/boot/dts/rockchip/rk3588s.dtsi \
    arch/${ARCH}/boot/dts/rockchip/rk3588s-orangepi-5-camera2.dtsi \
    arch/${ARCH}/boot/dts/rockchip/overlay/Makefile \
    arch/${ARCH}/boot/dts/rockchip/overlay/rk3588-ov13855-c2.dts \
    drivers/media/i2c/ov13855.c

