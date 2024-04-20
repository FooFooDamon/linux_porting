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
PKG_FILE ?= ./linux-orangepi-b03bc7f3661bd8fd41f8ca8011e28acdaeec0a67.tar.gz
#PKG_URL := https://github.com/orangepi-xunlong/linux-orangepi/archive/refs/heads/orange-pi-5.10-rk35xx.tar.gz
PKG_URL ?= https://github.com/orangepi-xunlong/linux-orangepi/archive/b03bc7f3661bd8fd41f8ca8011e28acdaeec0a67.tar.gz
KERNEL_IMAGE := Image
DTS_PATH := arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
INSTALL_DIR ?= $(if $(filter aarch64, $(shell uname -m)), /boot, ${HOME}/tftpd/orange-pi-5)
DEFCONFIG := arch/arm64/configs/rockchip_linux_defconfig
EXT_TARGETS += drivers/media/i2c/ov7670.ko \
    drivers/net/can/usb/peak_usb/peak_usb.ko
CUSTOM_FILES += arch/arm64/boot/dts/rockchip/Makefile \
    arch/arm64/boot/dts/rockchip/overlay/Makefile \
    arch/arm64/boot/dts/rockchip/rk3588s.dtsi

include linux_kernel.mk

USER_HELP_PRINTS := ${DEFAULT_USER_HELP_PRINTS} \
    echo "  * ${MAKE} bootscript"; \
    echo "  * ${MAKE} bootscript_install"; \
    echo "  * ${MAKE} fix_clangd_db";

${APPLY_DEFAULT_MODULE_TARGET_ALIAS}

.PHONY: bootscript bootscript_install

install: bootscript_install

bootscript_install: bootscript
	install boot.cmd boot.scr ${INSTALL_DIR}/
	krelease=$$(${MAKE} kernelrelease -C ${SRC_ROOT_DIR} ${MAKE_ARGS} -s | grep "^[0-9]\+"); \
	echo "fdt_dir=dtbs/$${krelease}" > ${INSTALL_DIR}/fdt_dir.txt

bootscript: boot.scr

boot.scr: boot.cmd
	mkimage -C none -A arm -T script -d $< $@

fix_clangd_db:
	sed -i -e '/"-f/d' -e '/"-mabi=lp64"/d' ${SRC_ROOT_DIR}/compile_commands.json

endif

