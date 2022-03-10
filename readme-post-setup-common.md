

# After completing steps for given image

## systemd must be setup

See [this](https://kubernetes.io/blog/2020/05/21/wsl-docker-kubernetes-on-the-windows-desktop/#minikube-enabling-systemd) link.

apt update and
apt install dbus-user-session


Run this command in wsl distro:  
```sudo sed -i 2a"# Start or enter a PID namespace in WSL2\nsource /usr/sbin/start-systemd-namespace\n" /etc/bash.bashrc```



TODO! SJekke denne!!
https://grigorkh.medium.com/fix-tzdata-hangs-docker-image-build-cdb52cc3360d