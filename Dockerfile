# just a copy of hagb/docker-easyconnect:7.6.7
# should be compatible with other versions, like 7.6.3
FROM battalion7244/auto-easyconnect:base-7.6.7


RUN sed -i s/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/ /etc/apt/sources.list && \
    sed -i s/security.debian.org/mirrors.tuna.tsinghua.edu.cn/ /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests \
    xdotool procps

COPY ./docker-root /

RUN groupadd -r socks && useradd -r -g socks socks

RUN chmod -R +x /usr/local/bin

CMD ["start.sh"]