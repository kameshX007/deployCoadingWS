#!/bin/sh
echo "Checking if VScode already deployed...">deployVScode.log;
container=$(docker ps -q --filter ancestor=vscodekasm )>>deployVScode.log;
[ -z "$container" ] && echo "No running container found">>deployVScode.log || docker rm -f $container;

echo "Building VScode image...">>deployVScode.log;
docker build . --file Dockerfile --tag vscodekasm;
echo "Image build successfully...">>deployVScode.log;

echo "Deploying VScode...">>deployVScode.log;
docker run -d -p 49154:6901 -e VNC_PW=2022 --restart=always --name vscodecontainer vscodekasm;
echo "VScode deployment successfull...">>deployVScode.log;
exit 0