# SPDX-License-Identifier: GPL-2.0

#
# Makefile wrapper for Linux kernel 6.1 of Orange Pi 5.
#
# Copyright (c) 2024 Man Hung-Coeng <udc577@126.com>
#

PKG_FILE := ./linux-orangepi-752c0d0a12fdce201da45852287b48382caa8c0f.tar.gz
#PKG_URL := https://github.com/orangepi-xunlong/linux-orangepi/archive/refs/heads/orange-pi-6.1-rk35xx.tar.gz
PKG_URL ?= https://github.com/orangepi-xunlong/linux-orangepi/archive/752c0d0a12fdce201da45852287b48382caa8c0f.tar.gz
CUSTOM_FILES += net/mac80211/util.c \
    net/mac80211/main.c \
    net/mac80211/ieee80211_i.h \
    drivers/net/wireless/realtek/rtl8xxxu/Kconfig \
    drivers/net/wireless/realtek/rtl8xxxu/Makefile \
    drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h \
    drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c \
    drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c \
    drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c \
    drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c \
    drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c \
    drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c \
    drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c \
    drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c \
    drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c \
    drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h

include ../default.mk

