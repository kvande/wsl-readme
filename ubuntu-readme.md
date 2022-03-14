# WSL with Ubuntu

## How to create wsl machine from Docker image


Got most of this from [here](https://medium.com/nerd-for-tech/create-your-own-wsl-distro-using-docker-226e8c9dbffe)
and [here](https://medium.com/@hoxunn/wsl-docker-custom-distro-2-0-730fd97fe72e), 
and wsl2 network issue fix from  [here](https://github.com/MicrosoftDocs/WSL/pull/1046).

## Prerequisite
In order to get wsl networking to work, run this command in Powershell as Admin, see [this link](https://github.com/MicrosoftDocs/WSL/pull/1046):  
```New-NetNat -Name "WSLNat" -InternalIPInterfaceAddressPrefix 100.109.0.0/24```


## For the Ubuntu Docker file:

### Run the Dockerfile with the following command (replace user name and password):  
```docker build --build-arg USER=user --build-arg PASSWORD=pass -t custom-wsl-ubuntu -f ubuntu-dockerfile . ```

### Run a container from that image (it should quit immediately)  

Regarding [--cap-add=NET_ADMIN](https://stackoverflow.com/questions/27708376/why-am-i-getting-an-rtnetlink-operation-not-permitted-when-using-pipework-with-d)  


```docker run --name custom-wsl-ubuntu-container --cap-add=NET_ADMIN custom-wsl-ubuntu```

### Export the image to a tar file  
```docker export --output=ubuntu.install.tar custom-wsl-ubuntu-container```

### Create the folder where the distro should be placed  
```...create folder and move the tar file to it...```

### Import the distro ('distro-name' 'location for the distro' 'the tar file' )  
```wsl.exe --import ubuntu-1 ./ ubuntu.install.tar```  

### Run the distro  (here: ubuntu-1)  
```wsl -d ubuntu-1 -u user```

## Post tasks  (important!) 

### Post task 1
Must update /etc/resolve.conf in order to get networking in order 

```sudo sh -c  'echo "nameserver 100.109.0.1" > /etc/resolv.conf'```  
```sudo chattr +i /etc/resolv.conf```  
```sudo service network-manager restart```  (seems to work even if this fails)  

Check that network is working  
```sudo apt update```

### Post task 2
After this step is performed, systemd is used instead of init, so no connection to wsl.exe anymore.

```sudo sed -i 2a"# Start or enter a PID namespace in WSL2\nsource /usr/sbin/start-systemd-namespace\n" /etc/bash.bashrc```


Then `exit` the WSL session, no need to stop it, and log back in. Wsl should now use systemd instead of init.

Run this command `ps -ef` to check that PID=1 now is in fact systemd.


Task for fixing networking issues, if any (does not work after Post task 2, have to run it from Windows?? if so have to rewrite it somehow)   
```sh /usr/user/wsl-network-fix/wsl-network-fixup.sh```



## Clean up  
Container  
```docker container rm custom-wsl-ubuntu-container```  

Image  
```Must be deleted via image id```  

Tar file  
```Delete it  manually in like Windows Explorer```  
