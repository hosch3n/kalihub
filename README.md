# kalihub

- 用于 kali-linux-2020.3-gnome-amd64.iso，其它版本不保证兼容

[1.add_source.sh](./1.add_source.sh) 添加中科大和官方的apt源、docker源

[2.install_app.sh](./2.install_app.sh) 安装常用软件

[3.get-pip.py](./3.get-pip.py) 安装pip2 `sudo python2.7 get-pip.py`
- 新Kali已经移除了python2-pip（pip2），需要手动安装 https://bootstrap.pypa.io/get-pip.py

[8.add_grub_passwd.sh](./8.add_grub_passwd.sh) 添加grub引导密码

[8.install_nvidia_driver.sh](./8.install_nvidia_driver.sh) 安装英伟达独显闭源驱动

[9.gen_passwds.sh](./9.gen_passwds.sh) 通过hashcat规则生成密码

[9.xray.sh](./9.xray.sh) XRay被动扫描模式

[9.buildAoiAWD.sh](./9.buildAoiAWD.sh) 自动编译生成AoiAWD，要先自行解决NodeJS与MongoDB的环境变量

[LookHere.zip](./LookHere.zip) AoiAWD编译后的二进制文件，稍微改了下插件

---

`dconf load / < ./config/dconf-settings.ini` 还原Gnome配置

---

`cp ./config/.ssh/config ~/.ssh/config` 设置ssh每60秒重连，避免超时挂了

---

`cp ./config/.gitconfig ~/.gitconfig` 还原gitconfig配置，注意修改文件里的email

---

`cp ./config/vimrc /etc/vim/vimrc` 还原vim配置，只是一些基础的配置

---

`update-alternatives --config java` 切换jdk版本，新的BurpSuite和CobaltStrike要用新openjdk，以前的用jdk1.8

---

[xdebug](./config/php.ini)、开启生成Phar、MongoDB、调整opcache 的配置文件

---

`find . -maxdepth 1 -type d ! -path . | xargs -L 1 bash -c 'cd "${0}" && pwd && git pull'` 批量更新当前路径下的git项目，灵活调整各命令和参数即可

---

```for i in `ip addr | sed -r -n 's/^[0-9]+: (.*):.*/\1/p' | grep -v 'lo\|wlan\|eth0\|docker0'`; do sudo ifconfig ${i} down; done``` 清掉一些残留的docker虚拟网卡

--- 

[Goldberg_Lan_Steam_Emu_v0.2.5.zip](./Goldberg_Lan_Steam_Emu_v0.2.5.zip) 是Steam模拟器，可以用来破解一些游戏的简单校验