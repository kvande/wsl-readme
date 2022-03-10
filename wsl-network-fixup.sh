#!/bin/sh

if ! ping 100.109.0.1 -W0.2 -c1 >/dev/null 2>&1; then
  echo "Fixing WSL network..."
  wsl.exe -d "$WSL_DISTRO_NAME" -u root bash -c "ip a flush dev eth0; ip addr add 100.109.0.10/24 dev eth0; ip route add default via 100.109.0.1; ip link set dev eth0 mtu 1400"
  echo "Please accept the privilege escalation prompt in the screen"
  powershell.exe -NoLogo -NoProfile -Command 'Exit (Start-Process powershell.exe -Wait -WindowStyle "Hidden" -PassThru -Verb runAs -ArgumentList "-NoLogo","-NoProfile","-Command","netsh interface ip set address name='"'"'vEthernet (WSL)'"'"' static 100.109.0.1 255.255.255.0 none").ExitCode'
  echo "Finished fixing WSL network."
fi
