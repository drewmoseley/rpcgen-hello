ARG CROSS_SDK_BASE_TAG=3.2.1-bookworm
ARG BASE_VERSION=3.2.1-bookworm
ARG IMAGE_ARCH=arm64

FROM torizon/debian-cross-toolchain-${IMAGE_ARCH}:${CROSS_SDK_BASE_TAG} As Build
RUN apt update && apt install -y libtirpc-dev:${IMAGE_ARCH} libtirpc3:${IMAGE_ARCH} rpcsvc-proto cpp 
COPY app /app
RUN if [ "$IMAGE_ARCH" = "arm64" ] ; then \
        make ARCH=${IMAGE_ARCH} CC=aarch64-linux-gnu-gcc ; \
    elif [ "$IMAGE_ARCH" = "arm" ] ; then \
        make ARCH=${IMAGE_ARCH} CC=arm-linux-gnueabihf-gcc ; \
    elif [ "$IMAGE_ARCH" = "amd64" ] ; then \
        make ARCH=${IMAGE_ARCH} CC=x86_64-linux-gnu-g++ ; \
    fi;

FROM --platform=linux/${IMAGE_ARCH} torizon/debian:${BASE_VERSION} AS Deploy
RUN apt update && apt install -y libtirpc3:${IMAGE_ARCH}
RUN mkdir /app
COPY --from=Build /app/msg_server /app/rprintmsg /app
WORKDIR /app
ENTRYPOINT [ "/bin/bash" ]
