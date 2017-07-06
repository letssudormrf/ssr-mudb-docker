FROM alpine

MAINTAINER letssudormrf

#Download applications
RUN set -ex \
    && if [ $(wget -qO- ipinfo.io/country) == CN ]; then echo "http://mirrors.aliyun.com/alpine/latest-stable/main/" > /etc/apk/repositories ;fi \
    && apk --update add --no-cache libsodium python git

#Make ssr-mudb
ENV PORT="443"
ENV PASSWORD="ssr-mudb-docker"
ENV METHOD="none"
ENV PROTOCOL="auth_chain_a"
ENV OBFS="tls1.2_ticket_auth"

RUN git clone https://github.com/shadowsocksr/shadowsocksr.git \
    && cd shadowsocksr \
    && chmod +x *.sh && chmod +x shadowsocks/*.sh && cp apiconfig.py userapiconfig.py && cp config.json user-config.json && sed -i 's/sspanelv2/mudbjson/' userapiconfig.py \
    && python mujson_mgr.py -a -u MUDB -p ${PORT} -k ${PASSWORD} -m ${METHOD} -O ${PROTOCOL} -o ${OBFS} -G "#"

#Execution environment
COPY start.sh /root/
RUN chmod a+x /root/start.sh
WORKDIR /shadowsocksr
ENTRYPOINT ["/root/start.sh"]
CMD python /shadowsocksr/server.py m>> ssserver.log 2>&1
