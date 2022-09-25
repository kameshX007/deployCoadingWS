#!/bin/sh
#Checking whether VNC password is passed to script
vncPassword=$2;
[ -z "$vncPassword" ] && echo "Please pass VNC password...!!!" && exit 0 || echo "Successfully got VNC password...";

#Checking whether username is passed to script
#A docker folder will be created inside this users home directory and container persistant data will be stored there
dockerUser=$1;
[ -z "$dockerUser" ] && echo "###Please pass username...!!!" && exit 0 || echo "Deploying container for user $dockerUser";

#Checking & Removing existing container
echo "Checking if coadingws already deployed...";
container=$(docker ps -q --filter ancestor=coadingws );
echo $container;
[ -z "$container" ] && echo "No running container found" || docker rm -f $container;

#Building image
echo "Building coadingws image...";
docker build . --file Dockerfile --tag coadingws;
echo "Image build successfully...";

#Deploying container
echo "Deploying VScode...";
docker run -d -p 6901:6901 -e VNC_PW=$vncPassword --restart=always -v /home/$dockerUser/docker/CoadingWS/kasm-user:/home/kasm-user --name coadingwscontainer coadingws;
echo "coadingws deployment successfull...";
exit 0