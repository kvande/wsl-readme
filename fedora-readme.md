# WSL with Fedora

## How to create wsl machine from Docker image


Got most of this from [here](https://medium.com/nerd-for-tech/create-your-own-wsl-distro-using-docker-226e8c9dbffe)
and [here](https://medium.com/@hoxunn/wsl-docker-custom-distro-2-0-730fd97fe72e), 
and wsl2 network issue fix from  [here](https://github.com/MicrosoftDocs/WSL/pull/1046).

## Prerequisite
In order to get wsl networking to work, run this command in Powershell as Admin, see [this link](https://github.com/MicrosoftDocs/WSL/pull/1046):  
```New-NetNat -Name "WSLNat" -InternalIPInterfaceAddressPrefix 100.109.0.0/24```


## For the Fedora Docker file:

### Run the Dockerfile with the following command (replace user name and password):  
```docker build --build-arg USER=user --build-arg PASSWORD=pass -t custom-wsl-fedora -f fedora-dockerfile . ```


### Run a container from that image (it should quit immediately)  

Regarding [--cap-add=NET_ADMIN](https://stackoverflow.com/questions/27708376/why-am-i-getting-an-rtnetlink-operation-not-permitted-when-using-pipework-with-d)  

```docker run --name custom-wsl-fedora-container --cap-add=NET_ADMIN custom-wsl-fedora```

### Export the image to a tar file  
```docker export --output=fedora.install.tar custom-wsl-fedora-container```

### Create the folder where the distro should be placed  
```...create folder and move the tar file to it...```

### Import the distro ('distro-name' 'location for the distro' 'the tar file' )  
```wsl.exe --import fedora-1 ./ fedora.install.tar```  

### Run the distro  (here: fedora-1)  
```wsl -d fedora-1 -u user```

## Post tasks (important!) 

### Post task 1
Must update /etc/resolve.conf in order to get networking in order 

```sudo sh -c  'echo "nameserver 100.109.0.1" > /etc/resolv.conf'```  
```sudo chattr +i /etc/resolv.conf```  
```sudo service network-manager restart```  (seems to work even if this fails)

### Post task 2
After this step is performed, systemd is used instead of init, so no connection to wsl.exe anymore.

```sudo sed -i 2a"# Start or enter a PID namespace in WSL2\nsource /usr/sbin/start-systemd-namespace\n"  /etc/bashrc```

Task for fixing networking issues, if any  
```sh /usr/user/wsl-network-fix/wsl-network-fixup.sh```



