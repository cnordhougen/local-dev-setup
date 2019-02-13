# Process management helpers.

function pse() {
    ps -efA | grep -e "$1" | grep -v grep | while read P; do
        PID=$(echo $P|awk '{ print $2 }')
        C=$(ps -ef|grep -Po "\d+\s+\d+\s+"$PID".+\d+:\d+.\d+\s+\K.+")
        
        if [[ $C ]]; then
            C=" -> "$C
        fi
        
        printf "$P$C\n"
    done
}

# Kill a process based on a regex search of ps -ef
function pk() {
    PROC=$(pse "$1")
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
