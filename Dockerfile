FROM ubuntu:latest
LABEL maintainter="ced0180"

ARG name=ubuntu
ENV DEBIAN_FRONTEND=noninteractive

RUN sed -i.org -e "s/\/\/archive\.ubuntu\.com/\/\/jp\.archive\.ubuntu\.com/g" /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y 
RUN apt-get install openssh-server -y
RUN mkdir /var/run/sshd

RUN apt-get install vim zsh git wget curl -y

RUN useradd -m -p `perl -e "print(crypt('ubuntu', 'a9'));"` -s /bin/bash ${name}
RUN chsh -s /bin/zsh ${name}

RUN mkdir /home/${name}/.ssh
RUN chown ${name}:${name} -R /home/${name}/.ssh

USER ${name}
RUN sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN chown ${name}:${name} -R /home/${name}/.oh-my-zsh

USER root
COPY .zshrc /home/${name}/.zshrc
RUN chown ${name}:${name} -R /home/${name}/.zshrc

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
