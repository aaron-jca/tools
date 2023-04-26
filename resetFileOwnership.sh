## RESET OWNERSHIP OF FILES
# when we create files in a docker image it has root ownership

CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo "Resetting file ownership."
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