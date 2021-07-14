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

RUN useradd -m -p `perl -e "print(crypt('${PASSWORD}', 'a9'));"` -s /bin/bash ${USERNAME}
RUN chsh -s /bin/zsh ${USERNAME}
RUN if [ "${USE_SUDO}}" = "1" ]; then usermod -aG sudo ${USERNAME}; fi

RUN mkdir /home/${USERNAME}/.ssh
RUN chown ${USERNAME}:${USERNAME} -R /home/${USERNAME}/.ssh

USER ${USERNAME}
RUN sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN chown ${USERNAME}:${USERNAME} -R /home/${USERNAME}/.oh-my-zsh

USER root
COPY .zshrc /home/${USERNAME}/.zshrc
RUN chown ${USERNAME}:${USERNAME} -R /home/${USERNAME}/.zshrc
COPY run /usr/local/bin/.run
RUN chmod +x /usr/local/bin/.run

EXPOSE 22
CMD /usr/sbin/sshd -D
