# SPDX-License-Identifier: GPL-2.0

#
# Default Makefile wrapper for Linux kernel of Orange Pi 5.
#
# Copyright (c) 2024 Man Hung-Coeng <udc577@126.com>
#

ifeq ($(shell [ -s __ver__.mk -a -s linux_kernel.mk ] && echo 1 || echo 0),0)

LAZY_CODING_URL ?= https://github.com/FooFooDamon/lazy_coding_skills

.PHONY: all help init

all help init:
	@for i in __ver__.mk linux_kernel.mk; \
	do \
		[ -s $${i} ] || wget -c "${LAZY_CODING_URL}/raw/main/makefile/$${i}"; \
	done
	@echo "~ ~ ~ Initialization finished successfully ~ ~ ~"
	@echo "Re-run your command again to continue your work."

else

include __ver__.mk

ARCH := arm64
CROSS_COMPILE := aarch64-linux-gnu-
PKG_FILE ?= ./linux-orangepi-orange-pi-5.10-rk3588.tar.gz
PKG_URL ?= https://github.com/orangepi-xunlong/linux-orangepi/archive/refs/heads/orange-pi-5.10-rk3588.tar.gz
KERNEL_IMAGE := Image
DTS_PATH := arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
INSTALL_DIR ?= ${HOME}/tftpd/orange-pi-5
DEFCONFIG := arch/arm64/configs/rockchip_linux_defconfig
CUSTOM_FILES ?= ${DEFCONFIG} \
    ${DTS_PATH}

include linux_kernel.mk

endif

