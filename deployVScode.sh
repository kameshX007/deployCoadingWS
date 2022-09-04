#!/bin/sh
#Checking whether VNC password is passed to script
vncPassword=$2;
[ -z "$vncPassword" ] && echo "###Please pass VNC password...!!!">deployVScode.log && exit 0 || echo "Successfully got VNC password...">deployVScode.log;

#Checking & Removing existing container
echo "Checking if VScode already deployed...">>deployVScode.log;
container=$(docker ps -q --filter ancestor=vscodekasm )>>deployVScode.log;
[ -z "$container" ] && echo "No running container found">>deployVScode.log || docker rm -f $container;

#Building image
echo "Building VScode image...">>deployVScode.log;
docker build . --file Dockerfile --tag vscodekasm;
echo "Image build successfully...">>deployVScode.log;

#Deploying container
echo "Deploying VScode...">>deployVScode.log;
docker run -d -p 49152:6901 -e VNC_PW=$vncPassword --restart=always --name vscodecontainer vscodekasm;
echo "VScode deployment successfull...">>deployVScode.log;
exit 0
