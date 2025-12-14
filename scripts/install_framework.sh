#!/bin/bash
FW=$1
if [ "$FW" = "django" ]; then
 apt install -y python3 python3-pip
 pip3 install django
fi
if [ "$FW" = "node" ]; then
 curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
 apt install -y nodejs
fi
