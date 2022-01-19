FROM ubuntu:20.04

RUN apt update -y && DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC \
    apt -y install tzdata xvfb x11vnc fluxbox novnc net-tools

COPY docker_entrypoint.sh /data/docker_entrypoint.sh
ENTRYPOINT [ "/data/docker_entrypoint.sh" ]

ENV GEOMETRY=1920x1080x16 \
    PORT=8080 \
    COMMANDLINE="bash /data/launch.sh"

COPY launch.sh /data/launch.sh

# If necessary, you can add one more build step to install additional
# packages here to speed up consequent builds by letting Docker reuse
# previous steps without full rebuild.

# As an example, here's xterm install line.
RUN apt install xterm
