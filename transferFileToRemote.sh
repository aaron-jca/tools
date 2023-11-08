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

FILENAME='afile'

source 'scp $FILENAME jca@192.168.167.241:/home/jca'

source 'ssh@jca@192.168.167.241'

source 'scp -P 2281 $FILENAME jca@3.x.x.x:/home/jca'

source 'ssh jca@3.x.x.x -p 2281'