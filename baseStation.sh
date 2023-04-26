
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[1;31m'
BROWN='\033[0;33m'
NC='\033[0m' # No Color

IP='192.168.167.77'

echo -e "\n${CYAN}Connecting to the Base Station at ${RED}192.168.167.77${NC}"
echo -e "(Setup with ${RED}digimesh${NC})\n"
ssh jca@$IP