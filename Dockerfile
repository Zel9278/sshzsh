FROM ubuntu:latest
LABEL maintainter="ced0180"

ENV USERNAME=ubuntu
ENV PASSWORD=ubuntu
ENV USE_SUDO=0

ENV DEBIAN_FRONTEND=noninteractive

RUN sed -i.org -e "s/\/\/archive\.ubuntu\.com/\/\/jp\.archive\.ubuntu\.com/g" /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y 
RUN apt-get install openssh-server -y
RUN mkdir /var/run/sshd

RUN apt-get install sudo vim zsh git wget curl -y
RUN apt-get install xorg wmaker xrdp lxtask dbus fuse xterm pavucontrol -y

RUN sed -i -- "s/#deb-src/deb-src/g" /etc/apt/sources.list && sed -i -- "s/# deb-src/deb-src/g" /etc/apt/sources.list
RUN apt-get update
RUN apt-get install build-essential dpkg-dev libpulse-dev -y
RUN cd /tmp && apt-get source pulseaudio && apt-get build-dep pulseaudio -y && cd pulseaudio-13.99.1 && ./configure \
    && cd .. && git clone https://github.com/neutrinolabs/pulseaudio-module-xrdp.git && cd pulseaudio-module-xrdp && ./bootstrap && ./configure PULSE_DIR=/tmp/pulseaudio-13.99.1 \
    && make && make install && cd /

COPY run /usr/local/bin/.run
RUN chmod +x /usr/local/bin/.run

COPY .zshrc /usr/local/share/.zshrc

EXPOSE 22
EXPOSE 3389
CMD /usr/local/bin/.run ${USERNAME} ${PASSWORD} ${USE_SUDO}