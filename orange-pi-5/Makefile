# SPDX-License-Identifier: GPL-2.0

#
# Top level Makefile for Linux kernel of Orange Pi 5.
#
# Copyright (c) 2024 Man Hung-Coeng <udc577@126.com>
#

KVER ?= $(firstword $(wildcard [0-9]*.[0-9]*))
KERNEL_IMAGE ?= Image
CORE_TARGETS := $(shell ${MAKE} -C ${KVER} help -s | sed -n "1,/^Extended directive/p" | awk '{ print $$3 }' | grep -v '^[-[*{<]')
EXT_TARGETS := $(shell ${MAKE} -C ${KVER} showvars -s | grep EXT_TARGETS | awk -F = '{ print $$2 }')
__MODULES := $(filter %.ko, ${EXT_TARGETS})
EXT_TARGETS += ${__MODULES:.ko=.ko-install}
USER_TARGETS := $(foreach i, $(notdir ${__MODULES:.ko=}), ${i} install_${i})

${KERNEL_IMAGE} ${CORE_TARGETS} ${EXT_TARGETS} ${USER_TARGETS} help: %:
	${MAKE} $@ -C ${KVER}

