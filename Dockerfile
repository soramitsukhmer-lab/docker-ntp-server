FROM alpine:3.16

ENV NTP_SERVERS=
ENV LOG_LEVEL=

ARG S6_OVERLAY_VERSION=3.1.2.1
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz.sha256 /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz.sha256 /tmp
RUN cd /tmp && sha256sum -c *.sha256 \
    ; tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz \
    ; tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz\
    ; rm s6-overlay-*.tar.xz*

RUN apk add --no-cache -Uu bash busybox libseccomp chrony
ADD rootfs /

HEALTHCHECK CMD chronyc tracking || exit 1
EXPOSE 123/udp
ENTRYPOINT [ "/init" ]
