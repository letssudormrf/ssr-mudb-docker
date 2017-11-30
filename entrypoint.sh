#!/bin/sh

GIT_PATH=${GIT_PATH:-"https://github.com/shadowsocksrr/shadowsocksr"}
PORT=${PORT:-"8443"}
PASSWORD=${PASSWORD:-"Shadowsocksr"}
METHOD=${METHOD:-"none"}
PROTOCOL=${PROTOCOL:-"auth_chain_a"}
OBFS=${OBFS:-"tls1.2_ticket_auth"}

if [ ! -d ${GIT_PATH##*/} ]; then
	git clone -b akkariiin/master ${GIT_PATH}
	cd ${GIT_PATH##*/}
	cp apiconfig.py userapiconfig.py
	cp config.json user-config.json
	sed -i 's/sspanelv2/mudbjson/' userapiconfig.py
	python mujson_mgr.py -a -u MUDB -p ${PORT} -k ${PASSWORD} -m ${METHOD} -O ${PROTOCOL} -o ${OBFS} -G "#"
fi

python /tmp/${GIT_PATH##*/}/server.py m >> /dev/stdout 2>&1
