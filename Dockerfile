FROM taehun3446/cuda:12.4.1-cudnn-devel-ubuntu22.04

ARG SSH_ROOT_PASSWORD=${SSH_ROOT_PASSWORD:-root}
ARG SSH_ROOT_PASSWORD=${SSH_ROOT_PASSWORD}

WORKDIR /app

COPY ./app/ /app/

RUN nala update && xargs -a packages.txt nala install -y --no-install-recommends \
  && apt autoclean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && echo "root:$SSH_ROOT_PASSWORD" | chpasswd \
  && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
  && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# RUN cd /lib/systemd/system/sysinit.target.wants/ \
#     && rm $(ls | grep -v systemd-tmpfiles-setup) \
#     && rm -f /lib/systemd/system/multi-user.target.wants/* \
#              /etc/systemd/system/*.wants/* \
#              /lib/systemd/system/local-fs.target.wants/* \
#              /lib/systemd/system/sockets.target.wants/*udev* \
#              /lib/systemd/system/sockets.target.wants/*initctl* \
#              /lib/systemd/system/basic.target.wants/* \
#              /lib/systemd/system/anaconda.target.wants/* \
#              /lib/systemd/system/plymouth* \
#              /lib/systemd/system/systemd-updare-utmp*

VOLUME [ /sys/fs/cgroup ]

CMD [ "/lib/systemd/systemd" ]
