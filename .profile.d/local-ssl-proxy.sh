function sslx() {
    if [ "$1" == "ls" ]; then
        ps -ef|grep -Eo '\-\-source=\d+ \-\-target=\d+'|sed -e 's/--source=//g'|sed -e 's/--target=/-> /g'
    elif [ "$1" == "killall" ]; then
        ps -ef|grep local-ssl-proxy|grep -v grep|awk '{ print $2 }'|sudo xargs kill -9
    else
        ps -ef|grep -E "local-ssl-proxy.+\-\-source="$1|awk '{ print $2 }'|sudo xargs kill -9
        sudo local-ssl-proxy --source=$1 --target=$2
    fi
}
