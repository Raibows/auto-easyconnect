## An automated version of docker-easyconnect-gui

基于[docker-easyconnect](https://github.com/Hagb/docker-easyconnect)，使用[xdotool](https://github.com/jordansissel/xdotool)模拟鼠标键盘操作，以自动化完成Easyconnect登录流程，包含TOTP双因子认证。

⚠：这是一个非常黑盒、非常暴力、非常简单的方法，可能需要耗费时间调节超参数。

## 使用

1. 确保你有docker，例如docker desktop

2. 运行期望：Easyconnect vpn在容器中运行，暴露http/socks代理接口，通过规则转发工具，将内网地址转发至代理接口，完成外网到内网的访问

3. 拉取镜像``docker pull battalion7244/sysuvpn:0.1`` 或clone本仓库从头构建 ``docker build -t battalion7244/sysuvpn:latest .``

4. 编辑``run.sh``，填写config：

   - LOGIN_URL: Easyconnect的认证地址，例如``https://sslvpn.sysu.edu.cn``
   - EC_USER: Easyconnect vpn账号
   - EC_PASSWORD: Easyconnect vpn密码
   - AUTH: TOTP code，有效期最好在20秒以上，这一步填写也可以自动化，参见[gauth](https://github.com/pcarrier/gauth)
   - ADDR_VNC: vnc地址，可以用来调试xdotool的参数，默认是127.0.0.1:5901
   - ADDR_SOCKS: socks5代理地址，默认是127.0.0.1:1080
   - ADDR_HTTP: http代理地址，默认是127.0.0.1:8888
   - SOCKS_USER: socks5代理认证的用户名，可以留空，则不需要密码
   - SOCKS_PASSWD: socks5代理的密码，可以留空，则不需要密码

5. 尝试运行``bash run.sh``，等待约30秒，试一试能否访问内网地址``example.com``

   ```bash
   curl --socks5 127.0.0.1:1080 -v https://example.com
   ```

6. 失败了怎么办？根据个人环境不同，可能需要调试xdotool的超参数，也就是调节每个需要外设输入的间隔时间，请编辑``docker-root/usr/local/bin/xdo.sh``文件，利用vnc、docker互动调试。自行构建docker镜像，尝试运行

## Credit

1. [docker-easyconnect](https://github.com/Hagb/docker-easyconnect)
2. [一种自动登录EasyConnect的思路](https://taoshu.in/auto-login-easyconnect-in-docker.html)

## License

GPL v3