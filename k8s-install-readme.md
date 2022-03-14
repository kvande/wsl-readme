



# How to install Kubernetes (k3s Kubernetes distro)

First, complete one of the installs like the one in 'ubuntu-readme.md'.


Decide which port k8s should. 6443 is default, but if running with multple k8s instance there will be a port conflict if that is used for all of them.

*Here running with port 6445*

*Disable load balancer, so that MetalLb must be installed later*
*Removing traefik ingress controller so that nginx ingress controller must be installed later*



curl -sfL https://get.k3s.io | sh -s - server --disable servicelb --disable traefik --write-kubeconfig-mode 644 --https-listen-port 6445



