SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )


gnome-terminal --tab -e "bash -c 'source $SCRIPT_DIR/startDocker.sh -n $1'"

# make sure the docker container has enough time to start up
sleep 1

source $SCRIPT_DIR/joinDocker.sh $1
