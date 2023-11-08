
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[1;31m'
BROWN='\033[0;33m'
NC='\033[0m' # No Color

IP='192.168.170.9'
echo -e "\n${CYAN}Connecting to the Eagle at ${RED}${IP}${NC}"
echo -e "(It has the ${RED}digimesh${NC} module & two ${RED}GPS${NC} modules)\n"
ssh jca@$IP
