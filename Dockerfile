FROM ubuntu:20.04

RUN apt update -y && DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC \
    apt -y install tzdata xvfb x11vnc fluxbox novnc net-tools

COPY docker_entrypoint.sh /data/docker_entrypoint.sh
ENTRYPOINT [ "/data/docker_entrypoint.sh" ]

ENV GEOMETRY=1920x1080x16 \
    PORT=8080 \
    COMMANDLINE="bash /data/launch.sh"

COPY launch.sh /data/launch.sh

COPY ddlc /data/ddlc
COPY [ "persistent", "/.renpy/Monika After Story" ]
RUN ln -sf "/.renpy/Monika After Story" /usr/share/novnc/persistent && \
    ln -sf /data/ddlc /usr/share/novnc/ddlc
