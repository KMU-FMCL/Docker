FROM taehun3446/cuda:12.4.1-cudnn-devel-ubuntu22.04 AS builder

WORKDIR /app

COPY ./app/packages.txt /app/

RUN add-apt-repository ppa:longsleep/golang-backports \
    && nala update && xargs -a packages.txt nala install -y --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./app/script/ /app/script/
COPY ./app/codec/ /app/codec/
COPY ./app/opencv/ /app/opencv/

# RUN './setup.sh'

ARG CUDA_ARCH
ARG CUDA_PTX

ENV PATH=/root/.cargo/bin:/root/.local/bin:/root/.go/bin:$PATH \
    CUDA_ARCH=${CUDA_ARCH} \
    CUDA_PTX=${CUDA_PTX}

# FROM taehun3446/cuda:12.4.1-cudnn-devel-ubuntu22.04

# ARG CUDA_ARCH
# ARG CUDA_PTX

# ENV PATH=/root/.cargo/bin:/root/.go/bin:/root/.node/bin:/root/.ruby/bin:/root/.local/bin:/root/.fzf/bin:$PATH \
#     TERM=xterm-256color \
#     LC_ALL=C.UTF-8 \
#     CUDA_ARCH=${CUDA_ARCH} \
#     CUDA_PTX=${CUDA_PTX}

# COPY --from=builder /app/Video_Codec_SDK_12.2.72/Interface/*.h /usr/local/cuda-12.4/targets/x86_64-linux/include/
# COPY --from=builder /app/Video_Codec_SDK_12.2.72/Lib/linux/stubs/x86_64/*.so /usr/local/cuda-12.4/lib64/
# COPY --from=builder /app/archive/gcc.sh /app/

# COPY --from=builder /app/setup.tar.gz /app/

# WORKDIR /app

# COPY ./app/opencv/ ./app/script/archive/gcc.sh /app/

# RUN nala update && xargs -a packages.txt nala install -y --no-install-recommends \
#     && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
#     && tar -xzvf /app/setup.tar.gz -C / && rm /app/setup.tar.gz

# RUN bash -c './opencv.sh'

# COPY ./app/PTX/ /app/

# RUN nvcc -ptx vectorAdd.cu -o vectorAdd.ptx

COPY ./app/zsh/* /root/
