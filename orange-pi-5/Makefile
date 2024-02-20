# SPDX-License-Identifier: GPL-2.0

#
# Top level Makefile for Linux kernel of Orange Pi 5.
#
# Copyright (c) 2024 Man Hung-Coeng <udc577@126.com>
#

KRELEASE ?= 5.10
export KERNEL_IMAGE := Image
export EXTRA_TARGETS := dtbs
TARGETS := ${KERNEL_IMAGE} all menuconfig help \
    download clean distclean install uninstall ${EXTRA_TARGETS}

${TARGETS}: %:
	${MAKE} $@ -C ${KRELEASE}

