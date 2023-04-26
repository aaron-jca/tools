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

NAME=n
echo -e "\nCreating new docker container..."
if [ $# -eq 0 ]
  then
     read -p "$(echo -e $BROWN "Input container name: " $NC)" NAME
else
  NAME=$1
fi

echo -e "${CYAN}Creating new docker container with name: ${GREEN}${NAME}${NC}"
echo ""


CLION_PATH=~/.local/share/JetBrains/Toolbox/apps/CLion/ch-0/223.8617.54
PYCHARM_PATH=~/.local/share/JetBrains/Toolbox/apps/PyCharm-P/ch-0/223.8617.48
JETBRAINS_PATH=~/.config/JetBrains/JetBrainsClient223.8214.51
WORKSPACE_NAME=humble

# IMAGE=jcaros.registry.jca/amd64/jcaros2:0.17.2-rc-b00006 # FOXY
# IMAGE=jcaroswip.registry.jca/amd64/jcaros2-build:0.0.1-wip-b00025 #humble build image 
IMAGE=jcaroswip.registry.jca/amd64/outrun:0.0.1-wip-b00005 # build image for digimesh stuff

echo -e "${CYAN}Running xhost command${NC}"
xhost +local:docker

drawWelcome

docker run -it -e DISPLAY -e QT_X11_NO_MITSHM=1 \
  --volume="$HOME/.Xauthority:/root/.Xauthority:rw" \
  --device /dev/dri --net=host --rm --entrypoint bash \
  --privileged \
  -v $CLION_PATH:/clion \
  -v $PYCHARM_PATH:/pycharm \
  -v $JETBRAINS_PATH:/root/.config/JetBrains \
  -v ~/$WORKSPACE_NAME:/Workspace \
  -v /dev:/dev \
  --name $NAME \
  $IMAGE

#### for eagle dev ####
# 
# docker run -it \
  # --rm --entrypoint bash \
  # -v ~/Workspace:/Workspace \
  # -v /dev:/dev \
  # --privileged \
  # jcaroswip.registry.jca/arm64/outrun:0.0.1-wip-b00005
