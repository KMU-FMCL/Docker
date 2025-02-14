FROM ros:noetic

WORKDIR /app

COPY ./app/ca-certificates/* /usr/local/share/ca-certificates/

RUN 'update-ca-certificates'

COPY ./app/ /app/

RUN './script/ubuntu_mirror.sh'

RUN apt update && xargs -a packages.txt apt install -y --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && ./script/nala.sh \
    && rm -rf ca-certificates script
