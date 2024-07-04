#!/bin/bash
## START A NEW DOCKER CONTAINER

BROWN='\033[0;33m'
RED='\033[1;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LGRAY='\033[0;37m'
LPURPLE='\033[1;35m'
NC='\033[0m' # No Color

drawLine() {
  x=0
  y=$(tput cols)
  while [ "$x" -lt "$y" ] 
  do 
    echo -n "="
    x=$((x+1))
  done
  echo -e "${NC}"
}

drawWelcome()
{
  echo -e -n "${GREEN}"
  drawLine
  echo -e "${BROWN}Finished. Welcome to ${RED}${NAME}${NC}"
  echo -e -n "${GREEN}"
  drawLine
}

NAME="notInitialized"
WORKSPACE_NAME=humble
CLION_PATH=/home/asalo/.local/share/JetBrains/ # apps/CLion/ch-0/223.8617.54 # move this up to toolbox directory to keep plugins and such
PYCHARM_PATH=~/.local/share/JetBrains/Toolbox/apps/PyCharm-P/ch-0/223.8617.48
JETBRAINS_PATH=~/.config/JetBrains/
IMAGE="notInitialized" #humble build image 

while getopts ":n:i:" o
do	case "$o" in
	n)	NAME=${OPTARG};;
	i)	IMAGE=${OPTARG};;
	[?])	print >&2 "Usage: $0 [-n name] [-i image]"
		exit 1;;
	esac
done

echo -e "\nCreating new docker container..."
echo -e "${CYAN}Workspace name: ${GREEN}${WORKSPACE_NAME}${NC}"
if [ $NAME = "notInitialized" ]
  then
     read -p "$(echo -e $BROWN "Input container name: " $NC)" NAME
fi

echo -e "${CYAN}Creating new docker container with name: ${GREEN}${NAME}${NC}"
echo ""

# IMAGE=jcaroswip.registry.jca/amd64/jcaros2-deploy:0.0.1-ROS-1129-further-optimizations-b00037
# IMAGE=jcaroswip.registry.jca/amd64/jcaros2-deploy:0.0.1-ROS-1129-b00031 # FOXY
if [ $IMAGE = "notInitialized" ]
  then
    IMAGE=jcaroswip.registry.jca/amd64/jcaros2-build:3.0.1-wip-b00090 #humble build image 
fi

echo -e "${CYAN}Using image ${BLUE}${IMAGE}${NC}"
echo -e "${CYAN}Running xhost command${NC}"
xhost +local:docker

drawWelcome

docker run -it -e DISPLAY -e QT_X11_NO_MITSHM=1 \
  --volume="$HOME/.Xauthority:/root/.Xauthority:rw" \
  --device /dev/dri --net=host --rm --entrypoint bash \
  --privileged \
  -v $CLION_PATH:/root/.local/share/JetBrains \
  -v $PYCHARM_PATH:/pycharm \
  -v $JETBRAINS_PATH:/root/.config/JetBrains \
  -v ~/$WORKSPACE_NAME:/Workspace \
  -v /dev:/dev \
  --name $NAME \
  $IMAGE

### for eagle dev ####

# docker run -it \
#   --rm --entrypoint bash \  
#   -v ~/Workspace:/Workspace \
#   -v /dev:/dev \
#   --privileged \
#   jcaroswip.registry.jca/arm64/outrun:0.0.1-wip-b00005
