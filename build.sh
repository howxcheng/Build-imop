#!/bin/bash

sudo bash -c 'bash <(curl -s https://build-scripts.immortalwrt.org/init_build_environment.sh)'

cd ~
git clone -b v24.10.2 --single-branch --filter=blob:none https://github.com/immortalwrt/immortalwrt

cd immortalwrt
echo "src-git nikki https://github.com/nikkinikki-org/OpenWrt-nikki.git;main" >> "feeds.conf.default"
./scripts/feeds update -a
./scripts/feeds install -a

rm -rf package/luci-app-mosdns package/v2ray-geodata feeds/packages/net/mosdns feeds/packages/net/v2ray-geodata feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 24.x feeds/packages/lang/golang

git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/luci-app-mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/luci-app-adguardhome

wget -O ~/openclash.zip https://github.com/vernesong/OpenClash/archive/master.zip
unzip ~/openclash.zip -d ~
rsync -a ~/OpenClash-master/luci-app-openclash/ ~/immortalwrt/package/luci-app-openclash/
rm -rf ~/openclash.zip ~/OpenClash-master

# patch
sed -i 's#GO_AMD64:=v1#GO_AMD64:=v3#g' feeds/packages/lang/golang/golang-values.mk
sed -i 's#llvm.download-ci-llvm=true#llvm.download-ci-llvm=false#g' feeds/packages/lang/rust/Makefile


sudo cp "$GITHUB_WORKSPACE"/config ~/immortalwrt/.config
sudo chown builduser:builduser ~/immortalwrt/.config
make defconfig
make -j$(($(nproc)+1))
