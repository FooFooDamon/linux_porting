# SPDX-License-Identifier: GPL-2.0

#
# Makefile wrapper for Linux kernel porting project.
#
# Copyright (c) 2024 Man Hung-Coeng <udc577@126.com>
#

override undefine LAZY_CODING_MAKEFILES
LAZY_CODING_MAKEFILES := __ver__.mk linux_kernel.mk

ifeq ($(shell [ true $(foreach i, ${LAZY_CODING_MAKEFILES}, -a -s ${i}) ] && echo 1 || echo 0),0)

.PHONY: all prepare

LAZY_CODING_URL ?= https://github.com/FooFooDamon/lazy_coding_skills

all prepare:
	@for i in ${LAZY_CODING_MAKEFILES}; \
	do \
		mkdir -p $$(dirname $${i}); \
		[ -s $${i} ] || wget -c -O $${i} "${LAZY_CODING_URL}/raw/main/makefile/$$(basename $${i})"; \
	done
	@echo "~ ~ ~ Minimum preparation finished successfully ~ ~ ~"
	@echo "Re-run your command again to continue your work."

else

include $(word 1, ${LAZY_CODING_MAKEFILES})

ARCH ?= arm64
CROSS_COMPILE ?= aarch64-linux-gnu-
PKG_FILE ?= ./linux-orangepi-b03bc7f3661bd8fd41f8ca8011e28acdaeec0a67.tar.gz
# -- Rule of URL --
# Example: GitHub
# URL prefix: https://github.com/<user>/<repo>
# Package suffix: tar.gz | zip
# Download by tag or release: <prefix>/archive/refs/tags/<tag>.<suffix>
# Download by branch: <prefix>/archive/refs/heads/<branch>.<suffix>
# Download by commit: <prefix>/archive/<full-commit-hash>.<suffix>
# See also: https://docs.github.com/en/repositories/working-with-files/using-files/downloading-source-code-archives
#PKG_URL ?= https://github.com/orangepi-xunlong/linux-orangepi/archive/refs/heads/orange-pi-5.10-rk35xx.tar.gz
PKG_URL ?= https://github.com/orangepi-xunlong/linux-orangepi/archive/b03bc7f3661bd8fd41f8ca8011e28acdaeec0a67.tar.gz
KERNEL_IMAGE ?= Image
DTS_PATH ?= arch/${ARCH}/boot/dts/rockchip/rk3588s-orangepi-5.dts
INSTALL_DIR ?= $(if $(filter aarch64, $(shell uname -m)), /boot, ${HOME}/tftpd/orange-pi-5)
DEFCONFIG ?= arch/${ARCH}/configs/rockchip_linux_defconfig
EXT_TARGETS += drivers/net/can/usb/peak_usb/peak_usb.ko
CUSTOM_FILES +=

include $(word 2, ${LAZY_CODING_MAKEFILES})

USER_HELP_PRINTS ?= ${DEFAULT_USER_HELP_PRINTS} \
    echo "  * ${MAKE} bootscript"; \
    echo "  * ${MAKE} bootscript_install"; \
    echo "  * ${MAKE} fix_clangd_db";

${APPLY_DEFAULT_MODULE_TARGET_ALIASES}

.PHONY: bootscript bootscript_install

install: bootscript_install

bootscript_install: bootscript
	install boot.cmd boot.scr ${INSTALL_DIR}/
	krelease=$$(${MAKE} kernelrelease -C ${SRC_ROOT_DIR} ${MAKE_ARGS} -s | grep "^[0-9]\+"); \
	sed -i "s/\(fdt_dir=\).*/\1dtbs\/$${krelease}/" ${INSTALL_DIR}/orangepiEnv.txt

bootscript: boot.scr

boot.scr: boot.cmd
	mkimage -C none -A arm -T script -d $< $@

fix_clangd_db:
	sed -i -e '/"-f/d' -e '/"-mabi=lp64"/d' ${SRC_ROOT_DIR}/compile_commands.json

-include ../../rsync.priv.mk

endif

