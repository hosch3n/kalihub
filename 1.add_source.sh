#!/bin/bash

declare -r USTC_MIRROR_SOURCE='
deb https://mirrors.ustc.edu.cn/kali kali-rolling main non-free contrib
#deb-src https://mirrors.ustc.edu.cn/kali kali-rolling main non-free contrib'

declare -r KALI_OFFICIAL_SOURCE='
deb https://http.kali.org/kali kali-rolling main non-free contrib
#deb-src https://http.kali.org/kali kali-rolling main non-free contrib'

declare -r DOCKER_DEBIAN_KEY='https://download.docker.com/linux/debian/gpg'

declare -r USTC_DOCKER_SOURCE='
deb [arch=amd64] https://mirrors.ustc.edu.cn/docker-ce/linux/debian buster stable'

declare -r DOCKER_OFFICIAL_SOURCE='
deb [arch=amd64] https://download.docker.com/linux/debian buster stable'

declare -r USTC_DOCKERHUB_SOURCE='
DOCKER_OPTS="--registry-mirror=https://docker.mirrors.ustc.edu.cn/"'

declare -r APT_SOURCES_FILE='/etc/apt/sources.list'

declare -r DOCKER_SOURCE_FILE='/etc/apt/sources.list.d/docker.list'

declare -r DOCKER_CONFIG_FILE='/etc/default/docker'

# Add USTC Mirror Source
echo "${USTC_MIRROR_SOURCE}" >> "${APT_SOURCES_FILE}"

# Add Kali Official Source
#echo "${KALI_OFFICIAL_SOURCE}" >> "${APT_SOURCES_FILE}"

# Add Docker Debian Key
curl -fsSL "${DOCKER_DEBIAN_KEY}" | apt-key add -

# Add USTC Docker Source
echo "${USTC_DOCKER_SOURCE}" >> "${DOCKER_SOURCE_FILE}"

# Add Docker Official Source
echo "${DOCKER_OFFICIAL_SOURCE}" >> "${DOCKER_SOURCE_FILE}"

# Add USTC DockerHub Source
echo "${USTC_DOCKERHUB_SOURCE}" >> "${DOCKER_CONFIG_FILE}"

# Enable 32-bit support
dpkg --add-architecture i386

# Execute
apt update
