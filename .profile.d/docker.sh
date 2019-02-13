# Temporarily resolves an issue with time synchronization between docker and the host system.
function dkr() {
    case "$1" in
        ssh)
            docker exec -i -t $2 /bin/bash;;
        ssh-by-img)
            docker exec -i -t $(docker ps | grep -E "^[0-9a-f]+ +"$2 | awk '{ print $1 }') /bin/bash;;
        stop-by-img)
            docker ps | grep -E "^[0-9a-f]+ +"$2 | awk '{ print $1 }' | xargs docker stop;;
        clean)
            docker container ls -a | awk '{ print $1 }' | grep -v 'CONTAINER' | xargs docker container rm
            docker image ls | grep '<none>' | awk '{ print $3 }' | xargs docker image rm;;
        fix-time-sync)
            docker run -it --rm --privileged --pid=host debian nsenter -t 1 -m -u -n -i date -u $(date -u +%m%d%H%M%Y);;
        *)
            echo "Unknown command "$1
    esac
}
