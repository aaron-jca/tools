# JOIN AN EXISTING DOCKER CONTAINER

CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[1;31m'
BROWN='\033[0;33m'
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
  echo -e "${BROWN}Welcome to ${RED}${NAME}${NC}"
  echo -e -n "${GREEN}"
  drawLine
}

docker ps

echo ""

NAME=n
if [ $# -eq 0 ]
  then
     read -p "$(echo -e $BROWN "What container do you want to join? " $NC)" NAME
else
  NAME=$1
fi

echo -e "${CYAN}Joining docker container: ${GREEN}${NAME}${NC}"

drawWelcome

docker exec -it $NAME bash
