FROM taehun3446/systemd-cupy:v13.3.0-12.4.1-ubuntu22.04

WORKDIR /app

COPY requirements.txt .

RUN pip3 install --no-cache-dir -r \
         requirements.txt
