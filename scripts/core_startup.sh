#!/bin/sh

xhost +local:root
docker start core

# Wait for grpcio to connect
sleep 3

docker exec -i core core-gui & disown
