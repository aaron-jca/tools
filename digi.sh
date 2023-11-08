
echo "Starting two sets of two terminals for digimesh testing"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# source startDocker.sh
gnome-terminal --command="bash -c 'source $SCRIPT_DIR/singleDigi.sh digi2'"

source $SCRIPT_DIR/singleDigi.sh digi1

# gnome-terminal -e "bash -c 'echo hello world; sleep 3'"
echo "done"
