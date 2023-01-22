FROM battalion7244/sysuvpn:0.0


RUN sed -i s/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/ /etc/apt/sources.list && \
    sed -i s/security.debian.org/mirrors.tuna.tsinghua.edu.cn/ /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests \
    xdotool procps

COPY ./docker-root /

RUN groupadd -r socks && useradd -r -g socks socks

RUN chmod -R +x /usr/local/bin

CMD ["start.sh"]