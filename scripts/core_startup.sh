#!/bin/sh

xhost +local:root
docker start core
docker exec -i core core-gui & disown
