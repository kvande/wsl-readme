


MESTE AV DETTE ER NÅ FLYTTET INN PÅ README RUNDT OMKRING



# How to install Kubernetes

Sjekk denne angående Pid1 problem

https://kubernetes.io/blog/2020/05/21/wsl-docker-kubernetes-on-the-windows-desktop/#minikube-enabling-systemd


sudo apt install -yqq daemonize dbus-user-session fontconfig

HUSK Å ENDRE DET SKRIPTET FRA  /usr/sbin/daemonize til /usr/bin/daemonize (altså ikke sbin men bin, (finn ut hvordan man endrer dette i apt ???))

/usr/sbin/daemonize /usr/bin/unshare --fork --pid --mount-proc /lib/systemd/systemd --system-unit=basic.target


Sjekk at alt fungerer etterpå med "ps -ef" PID=1 skal da være systemd



Hvis det oppstår feil kjør denne: sudo journalctl -u k3s.service  (må scrolle helt til bunn)

Var konflikt for port, da kan man ta unistall på k3s og deretter kjøre opp med en spesifikk port (mulig dette var for at Kubernetes også kjører i Docker Desktop)

curl -sfL https://get.k3s.io | sh -s - server --disable servicelb --disable traefik --write-kubeconfig-mode 644 --https-listen-port 6445

