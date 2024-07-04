## RESET OWNERSHIP OF FILES
# when we create files in a docker image it has root ownership

CYAN='\033[0;36m'
NC='\033[0m' # No Color
RED='\033[1;31m'

echo -e "${RED}"
echo "Resetting file ownership."

echo -e "${NC}Running commands:"
echo "sudo chgrp -R $(id -u) .
sudo chown -R $(id -u) ."

sudo chgrp -R $(id -u) .
sudo chown -R $(id -u) .

echo -e "${CYAN}"
echo " /%%%%%%%   /%%%%%%  /%%   /%% /%%%%%%%%";
echo "| %%__  %% /%%__  %%| %%% | %%| %%_____/";
echo "| %%  \ %%| %%  \ %%| %%%%| %%| %%      ";
echo "| %%  | %%| %%  | %%| %% %% %%| %%%%%   ";
echo "| %%  | %%| %%  | %%| %%  %%%%| %%__/   ";
echo "| %%  | %%| %%  | %%| %%\  %%%| %%      ";
echo "| %%%%%%%/|  %%%%%%/| %% \  %%| %%%%%%%%";
echo "|_______/  \______/ |__/  \__/|________/";
echo "                                        ";

echo -e "${NC}"