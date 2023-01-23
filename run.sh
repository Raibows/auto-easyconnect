#!/bin/bash

# ------------config---start----------------
LOGIN_URL="address_of_easyconnect_authentication"
EC_USER="your_username_for_login_easy_connect"
EC_PASSWORD="your_password_for_login_easy_connect"
AUTH="top_code_outlive_at_least_20_seconds"

ADDR_VNC="127.0.0.1:5901"
ADDR_SOCKS="127.0.0.1:1080"
ADDR_HTTP="127.0.0.1:8888"
SOCKS_USER="username_for_socks5"
SOCKS_PASSWD="password_for_socks5"
# ------------config---end----------------


if [ -z "${1}" ]; then
    echo "you don't pass the TOTP AUTH code"
else
    AUTH="${1}"
fi

echo -e "the TOTP AUTH code=${AUTH}\nmake sure it can outlive more than 20 seconds"


if [ -d "${HOME}/.ecdata" ]; then
    echo "you have to delete ${HOME}/.ecdata first"
    sudo rm -rf $HOME/.ecdata
fi


echo "VNC ${ADDR_VNC} DEFAULT PASSWORD=xxxx"
echo "SOCKS5 ${ADDR_SOCKS}"
echo "HTTP ${ADDR_HTTP}"

docker run --device /dev/net/tun --cap-add NET_ADMIN -ti -e PASSWORD=xxxx \
-e LOGIN_URL="${LOGIN_URL}" \
-e EC_USER="${EC_USER}" \
-e EC_PASSWORD="${EC_PASSWORD}" \
-e AUTH="${AUTH}" \
-e SOCKS_USER="${SOCKS_USER}" \
-e SOCKS_PASSWD="${SOCKS_PASSWD}" \
-v $HOME/.ecdata:/root \
-p "${ADDR_VNC}:5901" \
-p "${ADDR_SOCKS}:1080" \
-p "${ADDR_HTTP}:8888" \
battalion7244/auto-easyconnect:latest