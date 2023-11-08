
NAME="notInitialized"
WORKSPACE_NAME=base_station_testing

while getopts ":n:w:" o
do	case "$o" in
	n)	NAME=${OPTARG};;
	w)	WORKSPACE_NAME=${OPTARG};;
	[?])	print >&2 "Usage: $0 [-n name] [-w workspace_folder]"
		exit 1;;
	esac
done

echo -e "${CYAN}Workspace name: ${GREEN}${WORKSPACE_NAME}${CYAN}...${NC}"
echo -e "\nCreating new docker container..."
if [ $NAME = "notInitialized" ]
  then
     read -p "$(echo -e $BROWN "Input container name: " $NC)" NAME
fi

echo -e "${CYAN}Creating new docker container with name: ${GREEN}${NAME}${NC}"
echo ""


#### for eagle dev ####

docker run -it \
  --rm --entrypoint bash \
  -v ~/base_station_testing:/Workspace \
  -v /dev:/dev \
  --privileged \
  jcaeic/outrun:version-wip-b00016-arm64

