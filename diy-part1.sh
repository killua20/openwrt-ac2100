#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
set FORCE_UNSAFE_CONFIGURE=1
echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
echo 'src-git lua-maxminddb https://github.com/jerrykuku/lua-maxminddb.git' >>feeds.conf.default
echo 'src-git luci-app-vssr https://github.com/jerrykuku/luci-app-vssr.git' >>feeds.conf.default
echo "src-git openwisp_config https://github.com/openwisp/openwisp-config.git^1.0.0" >>feeds.conf.default
echo "src-git openwisp_monitoring https://github.com/openwisp/openwrt-openwisp-monitoring.git" >>feeds.conf.default
./scripts/feeds update -a
./scripts/feeds install -a
echo "CONFIG_PACKAGE_netjson-monitoring=y" >> .config
echo "CONFIG_PACKAGE_openwisp-monitoring=y" >> .config
make defconfig
make tools/install
make toolchain/install
make package/openwisp-monitoring/compile