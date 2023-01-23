## An automated version of docker-easyconnect

基于[docker-easyconnect/gui-7.6.7-version](https://github.com/Hagb/docker-easyconnect)，使用[xdotool](https://github.com/jordansissel/xdotool)模拟鼠标键盘操作，以自动化完成Easyconnect登录流程，包含TOTP双因子认证。

⚠：这是一个非常暴力的方法，可能需要耗费时间调节超参数。更好的办法请关注[issue 143](https://github.com/Hagb/docker-easyconnect/issues/143)

## 使用

1. 确保你有docker，例如docker desktop

2. 运行期望：Easyconnect vpn在容器中运行，暴露http/socks代理接口，通过规则转发工具，按需将内网地址转发至代理接口，完成外网到内网的访问、不影响其他网络路由。

3. 拉取镜像``docker pull battalion7244/auto-easyconnect:latest`` 或clone本仓库从头构建 ``docker build -t battalion7244/auto-easyconnect:latest .``如果Easyconnect 7.6.7版本不匹配，可以修改``Dockerfile``第一行，将其修改为基于[Hagb/docker-easyconnect](https://github.com/Hagb/docker-easyconnect) GUI所支持的版本

4. 编辑``run.sh``，填写config：

   - LOGIN_URL: Easyconnect的认证地址，例如``https://sslvpn.sysu.edu.cn/portal/#!/login``
   - EC_USER: Easyconnect vpn账号
   - EC_PASSWORD: Easyconnect vpn密码
   - AUTH: TOTP code，这一步填写也可以自动化，参见[gauth](https://github.com/pcarrier/gauth)
   - ADDR_VNC: vnc地址，可以用来调试xdotool的参数，默认是127.0.0.1:5901，访问密码``xxxx``
   - ADDR_SOCKS: socks5代理地址，默认是127.0.0.1:1080
   - ADDR_HTTP: http代理地址，默认是127.0.0.1:8888
   - SOCKS_USER: socks5代理认证的用户名，可以留空，则不需要密码
   - SOCKS_PASSWD: socks5代理的密码，可以留空，则不需要密码

5. 尝试运行``bash run.sh TOTPCODE``，``TOTPCODE``通常为6位数字，注意有效期需在20秒以上，若不为空，则覆盖配置中的``AUTH``

6. 等待约30秒，试一试能否访问内网地址``example.com``

   ```bash
   curl --socks5 127.0.0.1:1080 -U SOCKS_USER:SOCKS_PASSWD -v https://example.com
   ```

6. **失败了怎么办？**根据个人环境不同，需要调试xdotool的超参数，即相隔外设输入的间隔时间。请编辑``docker-root/usr/local/bin/xdo.sh``文件，利用vnc、docker互动调试。自行构建docker镜像，尝试运行

## Credit

1. [docker-easyconnect](https://github.com/Hagb/docker-easyconnect)
2. [一种自动登录EasyConnect的思路](https://taoshu.in/auto-login-easyconnect-in-docker.html)

## License

GPL v3