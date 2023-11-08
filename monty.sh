
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[1;31m'
BROWN='\033[0;33m'
NC='\033[0m' # No Color

IP='192.168.167.241'

echo -e "\n${CYAN}Connecting to ${BROWN}Monty${CYAN} at ${RED}${IP}${NC}"
ssh jca@$IP