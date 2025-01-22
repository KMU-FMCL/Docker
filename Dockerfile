FROM taehun3446/systemd-cuda:12.4.1-cudnn-devel-ubuntu22.04

COPY app/ /app/

RUN nala update && xargs -a packages.txt nala install -y --no-install-recommends \
         && python3 -m pip install --no-cache-dir -U setuptools pip \
         && pip3 install --no-cache-dir -r requirements.txt \
         && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
