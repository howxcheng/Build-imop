#!/bin/bash

cd /home/howx/immortalwrt
rm -rf package/luci-app-adguardhome package/luci-app-mosdns package/v2ray-geodata feeds/packages/net/mosdns feeds/packages/net/v2ray-geodata
rm -rf feeds/packages/lang/golang
git clone https://gh-proxy.com/github.com/sbwml/packages_lang_golang -b 25.x feeds/packages/lang/golang

git clone https://gh-proxy.com/github.com/sbwml/luci-app-mosdns -b v5 package/luci-app-mosdns
git clone https://gh-proxy.com/github.com/sbwml/v2ray-geodata package/v2ray-geodata

git clone https://gh-proxy.com/github.com/rufengsuixing/luci-app-adguardhome.git package/luci-app-adguardhome

rm -rf /home/howx/OpenClash-master
wget -O /tmp/openclash.zip https://gh-proxy.com/github.com/vernesong/OpenClash/archive/master.zip
unzip /tmp/openclash.zip -d /home/howx
rsync -a /home/howx/OpenClash-master/luci-app-openclash /home/howx/immortalwrt/package/luci-app-openclash
