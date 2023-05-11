FROM python:3.9.13-slim-buster

ENV TZ "Asia/Shanghai"

WORKDIR /mnt

COPY Docker/vuser/* /root/

    # 添加普通用户组
RUN groupadd -g 1000 vuser && \
    # 添加普通用户
    useradd vuser -r -m -u 1000 -g vuser && \
    # 复制Powerline至/usr/bin目录，并调整权限
    mv /root/powerline-go /usr/bin/powerline-go && chmod 755 /usr/bin/powerline-go && \
    # 为root用户添加python国内源
    mkdir ~/.pip && \
    echo '[global]' >> ~/.pip/pip.conf && \
    echo 'index-url = https://pypi.tuna.tsinghua.edu.cn/simple' >> ~/.pip/pip.conf && \
    echo '[install]' >> ~/.pip/pip.conf && \
    echo 'trusted-host = https://pypi.tuna.tsinghua.edu.cn' >> ~/.pip/pip.conf && \
    # 复制pip国内源配置至普通用户
    cp -rv ~/.pip /home/vuser/ && chown -R vuser:vuser /home/vuser/.pip && \
    # 修改系统软件包国内源
    sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list && \
    sed -i 's/security.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list && \
    # 添加 i386 环境支持
    dpkg --add-architecture i386 && \
    apt-get update && \
    # 安装常见软件库
    apt-get install curl wget patch pv git zip lbzip2 libncurses5 libncursesw5 vim -y && \
    # 安装 i386环境支持库
    apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 busybox lzma -y && \
    # 清理缓存
    apt-get clean && \
    # 切换python版本
    update-alternatives --install /usr/bin/python python /usr/local/bin/python3.9 1 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.9 1 && \
    # 为root用户和普通用户添加vim的扩展包管理工具
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    curl -fLo /home/vuser/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    cd /root && cp .vimrc .bashrc .bash_aliases /home/vuser/ && chown -R vuser:vuser /home/vuser && \
    # 创建 工具链目录
    mkdir /opt/toolchains && chmod 666 /opt/toolchains

CMD ["/bin/bash"]