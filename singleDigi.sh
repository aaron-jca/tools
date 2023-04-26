SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )


gnome-terminal --tab -e "bash -c 'source $SCRIPT_DIR/startDocker.sh $1'"
# gnome-terminal -e "bash -c 'source joinDocker.sh helo'"
source $SCRIPT_DIR/joinDocker.sh $1