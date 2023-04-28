
# might be useful for some manual testing... consider voluming in this file
# not really necessary, only if we need ot do things manually

source colcon test --packages-select <package_name> --event-handlers console_direct+

source colcon test-result --verbose --test-result-base build/<package_name>