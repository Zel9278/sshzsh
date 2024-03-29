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

RUN apt-get install sudo vim neovim zsh git wget curl neofetch -y

COPY run /usr/local/bin/.run
RUN chmod +x /usr/local/bin/.run

EXPOSE 22
CMD /usr/local/bin/.run ${USERNAME} ${PASSWORD} ${USE_SUDO}
