# Process management helpers.

# Kill a process based on a regex search of ps -ef
function pk() {
    PROC=$(ps -ef|grep -e "$1"|grep -v grep)
    CT=$(printf "$PROC\n"|wc -l)

    if [ $CT -lt 1 -o "$PROC" == "" ]; then
    	echo "No matching processes."
    else
        printf "$PROC\n"

        if [ $CT -gt 1 ]; then
            echo 'Multiple matches. Please enter a more specific pattern.'
        else
            echo 'Kill this process? [Y/n] \c'
            read CONFIRM

            if [ "$CONFIRM" == "Y" -o "$CONFIRM" == "y" -o "$CONFIRM" == "" ]; then
                echo $PROC | awk '{ print $2 }' | xargs kill -9
            fi
        fi
    fi
}
