#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.88.1/g' package/base-files/files/bin/config_generate

# Modify ustream-ssl
echo 'start modify ustream-ssl Makefile'
sed -i 's/e251189ed315f22ab63dc6f17b03178676e10c21fff0cdd863b294a3c51a1b5b/c48331dcfda73d16cb12a0aa069eb62a5c370428c7559011a7284a9ef67d3089/g' package/libs/ustream-ssl/Makefile
echo 'modify ustream-ssl Makefile OK'

# Add Debian Snapshot as a fallback for the 1.8.10 tarball with the same PKG_HASH.
erofs_makefile=tools/erofs-utils/Makefile
if grep -Eq '^PKG_VERSION[[:space:]]*:?=[[:space:]]*1\.8\.10[[:space:]]*$' "$erofs_makefile"; then
    sed -i '/^PKG_SOURCE_URL=https:\/\/git\.kernel\.org\/pub\/scm\/linux\/kernel\/git\/xiang\/erofs-utils\.git\/snapshot\/$/ {
        s|$| https://snapshot.debian.org/archive/debian/20250801T142337Z/pool/main/e/erofs-utils|
        a\
PKG_SOURCE_URL_FILE:=erofs-utils_1.8.10.orig.tar.gz
    }' "$erofs_makefile" || exit 1
fi

# Modify v2ray-plugin
# echo 'start modify v2ray-plugin Makefile'
# sed -i 's/5.25.0/5.17.0/g' feeds/small/v2ray-plugin/Makefile
# sed -i 's/64d2cc376c16ade97b8e2cce69e0c98d74f530dcf8a30cf7d22255969ca5c10d/035823fa70d0c7e6afa6cced6b9d6f8b29c05a5f28852ad5954e957b61337c9e/g' feeds/small/v2ray-plugin/Makefile
# echo 'modify v2ray-plugin Makefile OK'

# Modify aliyundrive-webdav
# echo 'start modify aliyundrive-webdav Makefile'
# sed -i 's/stripped/release/g' feeds/packages/multimedia/aliyundrive-webdav/Makefile
# echo 'modify aliyundrive-webdav Makefile OK'
