#!/bin/bash

# Enable HTTPS Support
apt install -y apt-transport-https

# Virtualization
apt install -y virtualbox docker-ce wine wine64
usermod -G vboxusers -a hosch3n

# Development
apt install -y php7.4-fpm tomcat9 redis golang jython
#npm install multihashes

# Dependency
apt install -y python-pip python3-pip python3-venv composer libssl-dev

# Debug
apt install -y php-xdebug gdb strace android-tools-adb fastboot

# Security
apt install -y foremost volatility apktool
gem install evil-winrm zsteg

# Common
apt install -y keepass2 fcitx fcitx-googlepinyin audacity ffmpeg obs-studio \
 aria2 mesa-utils

# SouGouPinyin
#apt install -y fcitx-libs qml-module-qtquick2 libqt5quickwidgets5
#dpkg -i sogouimebs_2.0.0.38+0428.1_amd64.deb

pip install pwntools zio
pip3 install docker-compose pyjwt pycryptodome py2exe threadpool you-get

# Proxy
bash <(curl -sL https://install.direct/go.sh)
