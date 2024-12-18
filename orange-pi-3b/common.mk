ARCH ?= arm64
CROSS_COMPILE ?= aarch64-linux-gnu-
KERNEL_IMAGE ?= Image
DTS_PATH ?= arch/${ARCH}/boot/dts/rockchip/rk3566-orangepi-3b-v2.dts
INSTALL_DIR ?= $(if $(filter aarch64, $(shell uname -m)), /boot, ${HOME}/tftpd/orange-pi-3b)
DEFCONFIG ?= arch/${ARCH}/configs/rockchip_linux_defconfig
EXT_TARGETS +=
CUSTOM_FILES += arch/${ARCH}/boot/dts/rockchip/Makefile \
    arch/${ARCH}/boot/dts/rockchip/overlay/Makefile

USER_HELP_PRINTS ?= ${DEFAULT_USER_HELP_PRINTS} \
    echo "  * ${MAKE} update_fdt_dir"; \
    echo "  * ${MAKE} fix_clangd_db";

.PHONY: ${KERNEL_IMAGE} update_fdt_dir fix_clangd_db

# NOTE: Explicitly specify the first target of u-boot.mk as the default target.
${KERNEL_IMAGE}:

update_fdt_dir:
	krelease=$$(${MAKE} kernelrelease -C ${SRC_ROOT_DIR} ${MAKE_ARGS} -s | grep "^[0-9]\+"); \
	sed -i "s/\(fdt_dir=\).*/\1dtbs\/$${krelease}/" ${INSTALL_DIR}/orangepiEnv.txt

dtbs_install: update_fdt_dir

fix_clangd_db:
	sed -i -e '/"-f/d' -e '/"-mabi=lp64"/d' ${SRC_ROOT_DIR}/compile_commands.json

