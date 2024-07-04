#!/bin/bash

BROWN='\033[0;33m'
RED='\033[1;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LGRAY='\033[0;37m'
LPURPLE='\033[1;35m'
NC='\033[0m' # No Color

maxPos=60
minPos=5

pos=10
colourCountC1=34
colourCountC2=0
colourChangeC1=100
colourChangeC2=100

export PATH="/usr/bin/python3:$PATH"
export PATH="./.local/lib/python3.10/site-packages:$PATH"

echo "Running with Python version: $(python3 --version)"
echo "PATH: $PATH"
chooseColorC1() {
    r=$(( ( RANDOM % 8 )  + 1 ))
    case $r in
		1)
            C1=$BROWN
			;;
		2) 
            C1=$RED
			;;
		3)
            C1=$GREEN
			;;
		4)
            C1=$BLUE
			;;
		5)
            C1=$PURPLE
			;;
		6)
            C1=$LGRAY
			;;
		7)
            C1=$LPURPLE
			;;
		*)
            C1=$NC
			;;
	esac		
}
chooseColorC2() {
    r=$(( ( RANDOM % 8 )  + 1 ))
    case $r in
		1)
            C2=$BROWN
			;;
		2) 
            C2=$RED
			;;
		3)
            C2=$GREEN
			;;
		4)
            C2=$BLUE
			;;
		5)
            C2=$PURPLE
			;;
		6)
            C2=$LGRAY
			;;
		7)
            C2=$LPURPLE
			;;
		*)
            C2=$NC
			;;
	esac		
}

drawLine() {
    a=0
    while [ $a -lt $pos ]
    do
        echo -e -n "${C1}▩"
        a=$((a+1))
    done


    y=$(tput cols)
    while [ $a -lt $y ]
    do
        echo -e -n "${C2}❂"
        a=$((a+1))
    done
}
startPgm() {
    openfortivpn
}

if ! [ $(id -u) = 0 ]; then
   echo "The script need to be run as root." >&2
   exit 1
fi

startPgm &

if [ $SUDO_USER ]; then
    real_user=$SUDO_USER
else
    real_user=$(whoami)
fi

chooseColorC1
chooseColorC2

while true
do
    /usr/bin/python3 /home/asalo/tools/graphics/drawCube.py
    # sleep 0.3
    # drawLine+
    # if [ $pos -lt $minPos ]
    # then
    #     diff=$(($RANDOM%3))
    # elif [ $pos -gt $maxPos ]
    # then
    #     diff=$(($RANDOM%3-4))
    # else       
    #     diff=$(($RANDOM%18-6))   
    # fi

    # if [ $colourCountC1 -gt $colourChangeC1 ]
    # then
    #     colourCountC1=0
    #     chooseColorC1
    # fi
    # if [ $colourCountC2 -gt $colourChangeC2 ]
    # then
    #     colourCountC2=0
    #     chooseColorC2
    # fi
    # colourCountC1=$((colourCountC1+1))
    # colourCountC2=$((colourCountC2+1))
    # pos=$((pos+diff))
done