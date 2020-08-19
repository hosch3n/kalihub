#!/bin/bash
cd ~/XRay
filename="$(uuidgen).html"
./xray_linux_amd64 webscan --listen 127.0.0.1:7777 --html-output ${filename}