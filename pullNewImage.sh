# pulls a docker image


CYAN='\033[0;36m'
GREEN='\033[0;32m'
BROWN='\033[0;33m'
NC='\033[0m' # No Color

docker ps

echo""

NAME=n
if [ $# -eq 0 ]
  then
     read -p "$(echo -e $BROWN "What image do you want to pull? " $NC)" NAME
else
  NAME=$1
fi

echo -e "${CYAN}Pulling docker container: ${GREEN}${NAME}${NC}"

docker pull $NAME
