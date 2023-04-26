
echo "Starting two sets of two terminals"

# source startDocker.sh
gnome-terminal -e "bash -c 'source startDocker.sh helo'"
gnome-terminal -e "bash -c 'source joinDocker.sh helo'"

gnome-terminal -e "bash -c 'source startDocker.sh hi'"
gnome-terminal -e "bash -c 'source joinDocker.sh hi'"

# gnome-terminal -e "bash -c 'echo hello world; sleep 3'"
echo "done"