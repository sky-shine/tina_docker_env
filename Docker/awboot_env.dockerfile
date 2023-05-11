    # 使用python2.7的精简版debian镜像作为基础
FROM python:2.7-slim-buster
    # 调整时区
ENV TZ "Asia/Shanghai"
    # 设置默认工作路径
WORKDIR /mnt
    # 拷贝主机的目录内容（.bashrc以及可执行的repo程序）到镜像内
COPY Docker/vuser/* /root/
    # 添加普通用户组
RUN groupadd -g 1000 tina && \
    # 添加普通用户
    useradd vuser -r -m --uid 1000 -g tina --shell /bin/bash && \
    # 复制Powerline至/usr/bin目录，并调整权限
    mv /root/powerline-go /usr/bin/powerline-go && chmod 755 /usr/bin/powerline-go && \
    # 为root用户添加python国内源
    mkdir ~/.pip && \
    echo '[global]' >> ~/.pip/pip.conf && \
    echo 'index-url = https://pypi.tuna.tsinghua.edu.cn/simple' >> ~/.pip/pip.conf && \
    echo '[install]' >> ~/.pip/pip.conf && \
    echo 'trusted-host = https://pypi.tuna.tsinghua.edu.cn' >> ~/.pip/pip.conf && \
    # 复制pip国内源配置至普通用户
    cp -rv ~/.pip /home/vuser/ && chown -R vuser:tina /home/vuser/.pip && \
    # 修改系统软件包国内源
    sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list && \
    sed -i 's/security.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list && \
    # 添加 i386 环境支持
    dpkg --add-architecture i386 && \
    apt-get update && apt-get install apt-utils -y && \
    # 安装常见软件库
    apt-get install curl wget pv git lbzip2 libncurses5 libncursesw5 nano -y && \
    # 安装buildroot 必须依赖的软件库 lack gcc g++
    apt-get install sed gawk make binutils diffutils bash patch gzip bzip2 perl \
            tar cpio unzip rsync bc gawk libncurses-dev libssl-dev zlib1g-dev xz-utils file -y && \
    # 安装 i386环境支持库
    apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 busybox rsync lzma -y && \
    # 安装xxd
    apt-get install xxd -y && \
    # 安装gcc-arm-none-eabi
    mkdir -p /root/tmp && cd /root/tmp && \
    wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2019q3/RC1.1/gcc-arm-none-eabi-8-2019-q3-update-linux.tar.bz2 && \
    tar jxf gcc-arm-none-eabi-8-2019-q3-update-linux.tar.bz2 && \
    mkdir -p /usr/local && \
    cp -R gcc-arm-none-eabi-8-2019-q3-update/* /usr/local && \
    rm -rf gcc-arm-none-eabi-8-2019-q3-update && \
    rm -rf gcc-arm-none-eabi-8-2019-q3-update-linux.tar.bz2 && \
    # 清理缓存，减少镜像体积
    apt-get clean && \
    # 复制bashrc配置文件到vuser用户
    cd /root && cp .bashrc .bash_aliases /home/vuser/ && chown -R vuser:tina /home/vuser && \
    # 创建工具链目录
    mkdir /opt/toolchains && chmod 666 /opt/toolchains
    # 容器创建后，默认登陆以bash作为登陆环境
CMD ["/bin/bash"]