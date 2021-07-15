# sshzsh - wmaker branch(xrdp)

Build: use vscode docker extention
Run: docker run --it -p 22:22/tcp -p 3389:3389/tcp sshzsh:wmaker-xrdp
Run on sudo user: docker run --it -p 22:22/tcp -p 3389:3389/tcp -e USE_SUDO=1 sshzsh:wmaker-xrdp

Default username, password: ubuntu

Connect command: ssh -p 10022 ubuntu@localhost

xrdp port: 3389