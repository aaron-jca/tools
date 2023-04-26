
echo "Starting two terminals for base station testing"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )


gnome-terminal --tab -e "bash -c 'source $SCRIPT_DIR/baseStation.sh'"
# gnome-terminal -e "bash -c 'source joinDocker.sh helo'"
source $SCRIPT_DIR/baseStation.sh