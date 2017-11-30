#!/bin/sh

PORT=${PORT:-"8443"}
PASSWORD=${PASSWORD:-"Shadowsocksr"}
METHOD=${METHOD:-"none"}
PROTOCOL=${PROTOCOL:-"auth_chain_a"}
OBFS=${OBFS:-"tls1.2_ticket_auth"}

if [ ! -f mudb.json ]; then
	python mujson_mgr.py -a -u MUDB -p ${PORT} -k ${PASSWORD} -m ${METHOD} -O ${PROTOCOL} -o ${OBFS} -G "#"
fi

python server.py m >> /dev/stdout 2>&1
