FROM alpine

MAINTAINER letssudormrf

#Download applications
RUN set -ex \
    && if [ $(wget -qO- ipinfo.io/country) == CN ]; then echo "http://mirrors.aliyun.com/alpine/latest-stable/main/" > /etc/apk/repositories ;fi \
    && apk --update add --no-cache libsodium python git

#Make ssr-mudb
ENV SERVER_PORT="443"
ENV PASSWORD="ssr-mudb-docker"
ENV METHOD="chacha20"
ENV PROTOCOL="auth_aes128_md5"
ENV OBFS="tls1.2_ticket_auth"

RUN git clone https://github.com/shadowsocksr/shadowsocksr.git \
    && cd shadowsocksr \
    && chmod +x *.sh && chmod +x shadowsocks/*.sh && cp apiconfig.py userapiconfig.py && cp config.json user-config.json && sed -i 's/sspanelv2/mudbjson/' userapiconfig.py \
    && python mujson_mgr.py -a -u MUDB -p ${SERVER_PORT} -k ${PASSWORD} -m ${METHOD} -O ${PROTOCOL} -o ${OBFS} -G "#"

#Execution environment
WORKDIR /shadowsocksr
CMD python /shadowsocksr/server.py m
