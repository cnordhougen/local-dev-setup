# Makes local-ssl-proxy easier to work with
function sslx() {
    if [ "$1" == "" ]; then
        echo 'USAGE:'
        echo 'sslx SOURCE TARGET'
        echo '    Start a proxy from HTTPS on port SOURCE to HTTP on port TARGET.'
        echo '    If there is already a proxy running for that source port, it will be killed.'
        echo 'sslx kill SOURCE'
        echo '    Kill any running proxy for given source port'
        echo 'sslx killall'
        echo '    Kill all running proxies'
        echo 'sslx ls'
        echo '    List all running proxies'
    elif [ "$1" == "ls" ]; then
        ps -ef|grep -Eo 'node .+local-ssl-proxy.+\-\-source=\d+ \-\-target=\d+'|sed -E 's/.+\-\-source=//g'|sed -E 's/\-\-target=/-> /g'
    elif [ "$1" == "kill" ]; then
        ps -ef|grep -E "local-ssl-proxy.+\-\-source="$1|awk '{ print $2 }'|sudo xargs kill -9
    elif [ "$1" == "killall" ]; then
        ps -ef|grep local-ssl-proxy|grep -v grep|awk '{ print $2 }'|sudo xargs kill -9
    elif [ $1 -lt 1024 ]; then
        ps -ef|grep -E "local-ssl-proxy.+\-\-source="$1|awk '{ print $2 }'|sudo xargs kill -9
        sudo local-ssl-proxy --source=$1 --target=$2
    else
        ps -ef|grep -E "local-ssl-proxy.+\-\-source="$1|awk '{ print $2 }'|xargs kill -9
        local-ssl-proxy --source=$1 --target=$2
    fi
}
