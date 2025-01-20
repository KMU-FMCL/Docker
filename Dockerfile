FROM taehun3446/systemd-cuda:12.4.1-cudnn-devel-ubuntu22.04

COPY requirements.txt .

RUN echo "libcutensor2\nlibcutensor-dev\nlibcusparselt0\nlibcusparselt-dev\npython3\npython3-dev\npython3-pip" > packages.txt \
         && nala update && xargs -a packages.txt nala install -y --no-install-recommends \
         && apt autoclean \
         && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
         && python3 -m pip install --no-cache-dir -U setuptools pip \
         && pip3 install --no-cache-dir -r \
                 requirements.txt
