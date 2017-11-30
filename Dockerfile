FROM alpine

MAINTAINER letssudormrf

#Download applications
RUN set -ex \
    && if [ $(wget -qO- ipinfo.io/country) == CN ]; then echo "http://mirrors.aliyun.com/alpine/latest-stable/main/" > /etc/apk/repositories ;fi \
    && apk --update add --no-cache libsodium python git

RUN git clone -b akkariiin/master https://github.com/letssudormrf/shadowsocksr \
    && cd shadowsocksr \
    && chmod +x *.sh \
    && chmod +x shadowsocks/*.sh \
    && cp apiconfig.py userapiconfig.py \
    && cp config.json user-config.json \
    && sed -i 's/sspanelv2/mudbjson/' userapiconfig.py \
    && rm mudb.json \
    && chmod -R o+w /shadowsocksr

#Execution environment
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 8443

WORKDIR /shadowsocksr

CMD ["entrypoint.sh"]
