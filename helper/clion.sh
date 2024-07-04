#Setup ros2 and start Clion

BROWN='\033[0;33m'
RED='\033[1;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LGRAY='\033[0;37m'
LPURPLE='\033[1;35m'
NC='\033[0m' # No Color

drawPgm3() {
    echo "      ___           ___                    ___           ___     ";
    echo "     /  /\\         /  /\\       ___        /  /\\         /  /\\    ";
    echo "    /  /::\\       /  /:/      /__/\\      /  /::\\       /  /::|   ";
    echo "   /  /:/\\:\\     /  /:/       \\__\\:\\    /  /:/\\:\\     /  /:|:|   ";
    echo "  /  /:/  \\:\\   /  /:/        /  /::\\  /  /:/  \\:\\   /  /:/|:|__ ";
    echo " /__/:/ \\  \\:\\ /__/:/      __/  /:/\\/ /__/:/ \\__\\:\\ /__/:/ |:| /\\\\";
    echo " \\  \\:\\  \\__\\/ \\  \\:\\     /__/\\/:/~~  \\  \\:\\ /  /:/ \\__\\/  |:|/:/";
    echo "  \\  \\:\\        \\  \\:\\    \\  \\::/      \\  \\:\\  /:/      |  |:/:/ ";
    echo "   \\  \\:\\        \\  \\:\\    \\  \\:\\       \\  \\:\\/:/       |__|::/  ";
    echo "    \\  \\:\\        \\  \\:\\    \\__\\/        \\  \\::/        /__/:/   ";
    echo "     \\__\\/         \\__\\/                  \\__\\/         \\__\\/    ";
    echo -e "${NC}"
}

drawPgm2() {
    echo " ▄████▄   ██▓     ██▓ ▒█████   ███▄    █ ";
    echo "▒██▀ ▀█  ▓██▒    ▓██▒▒██▒  ██▒ ██ ▀█   █ ";
    echo "▒▓█    ▄ ▒██░    ▒██▒▒██░  ██▒▓██  ▀█ ██▒";
    echo "▒▓▓▄ ▄██▒▒██░    ░██░▒██   ██░▓██▒  ▐▌██▒";
    echo "▒ ▓███▀ ░░██████▒░██░░ ████▓▒░▒██░   ▓██░";
    echo "░ ░▒ ▒  ░░ ▒░▓  ░░▓  ░ ▒░▒░▒░ ░ ▒░   ▒ ▒ ";
    echo "  ░  ▒   ░ ░ ▒  ░ ▒ ░  ░ ▒ ▒░ ░ ░░   ░ ▒░";
    echo "░          ░ ░    ▒ ░░ ░ ░ ▒     ░   ░ ░ ";
    echo "░ ░          ░  ░ ░      ░ ░           ░ ";
    echo "░                                        ";
    echo -e "${NC}"
}

drawPgm() {
    echo " ▄████████  ▄█        ▄█   ▄██████▄  ███▄▄▄▄   ";
    echo "███    ███ ███       ███  ███    ███ ███▀▀▀██▄ ";
    echo "███    █▀  ███       ███▌ ███    ███ ███   ███ ";
    echo "███        ███       ███▌ ███    ███ ███   ███ ";
    echo "███        ███       ███▌ ███    ███ ███   ███ ";
    echo "███    █▄  ███       ███  ███    ███ ███   ███ ";
    echo "███    ███ ███▌    ▄ ███  ███    ███ ███   ███ ";
    echo "████████▀  █████▄▄██ █▀    ▀██████▀   ▀█   █▀  ";
    echo "           ▀                                   ";
    echo -e "${NC}"
}

chooseColor() {
    r=$(( ( RANDOM % 8 )  + 1 ))
    case $r in
		1)
            echo -e "${BROWN}"
			;;
		2) 
            echo -e "${RED}"
			;;
		3)
            echo -e "${GREEN}"
			;;
		4)
            echo -e "${BLUE}"
			;;
		5)
            echo -e "${PURPLE}"
			;;
		6)
            echo -e "${LGRAY}"
			;;
		7)
            echo -e "${LPURPLE}"
			;;
		*)
            echo -e "${NC}"
			;;
	esac		

}
startPgm() {

    exec $BASE_DIRECTORY/.local/share/JetBrains/Toolbox/apps/clion/bin/clion.sh 
}

echo -e "${CYAN}====================${NC}"
echo -e "${CYAN}Setting up for clion${NC}"

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
echo -e "${RED}Finished setup. Starting clion${NC}"
echo -e "${GREEN}==============================${NC}"

startPgm & 

x=0
while :
do
    sleep 12
    chooseColor
    if [ "$x" -eq 1 ]
        then
            drawPgm3
            x=$((x+1))
    elif [ "$x" -eq 0 ]
        then
            drawPgm
            x=$((x+1))
    else
            drawPgm2
            x=0
    fi
done
