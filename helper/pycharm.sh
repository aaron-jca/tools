#Setup ros2 and start Clion

BROWN='\033[0;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color


drawPgm() { 
echo "   ▄███████▄ ▄██   ▄    ▄████████    ▄█    █▄       ▄████████    ▄████████   ▄▄▄▄███▄▄▄▄   ";
echo "  ███    ███ ███   ██▄ ███    ███   ███    ███     ███    ███   ███    ███ ▄██▀▀▀███▀▀▀██▄ ";
echo "  ███    ███ ███▄▄▄███ ███    █▀    ███    ███     ███    ███   ███    ███ ███   ███   ███ ";
echo "  ███    ███ ▀▀▀▀▀▀███ ███         ▄███▄▄▄▄███▄▄   ███    ███  ▄███▄▄▄▄██▀ ███   ███   ███ ";
echo "▀█████████▀  ▄██   ███ ███        ▀▀███▀▀▀▀███▀  ▀███████████ ▀▀███▀▀▀▀▀   ███   ███   ███ ";
echo "  ███        ███   ███ ███    █▄    ███    ███     ███    ███ ▀███████████ ███   ███   ███ ";
echo "  ███        ███   ███ ███    ███   ███    ███     ███    ███   ███    ███ ███   ███   ███ ";
echo " ▄████▀       ▀█████▀  ████████▀    ███    █▀      ███    █▀    ███    ███  ▀█   ███   █▀  ";
echo "                                                                ███    ███                 ";

}

startPgm() {

    exec $BASE_DIRECTORY/pycharm/bin/pycharm.sh
}

echo -e "${CYAN}====================${NC}"
echo -e "${CYAN}Setting up for pycharm${NC}"

echo ""
echo -e "${CYAN}Setting up ros2 environment${NC}"
# setup ros2 environment
source "/opt/ros/$ROS_DISTRO/setup.bash" --
exec "$@"
echo -e "${GREEN}Done!${NC}"

echo ""
echo -e "${CYAN}Installing libxtst6${NC}"
apt install libxtst6
echo -e "${GREEN}Done!${NC}"
echo""

echo -e "${GREEN}==============================${NC}"
echo -e "${BROWN}Finished setup. Starting pycharm${NC}"
echo -e "${GREEN}==============================${NC}"

startPgm & 

while :
do 
    sleep 5
    drawPgm
done

