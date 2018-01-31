# Temporarily resolves an issue with time synchronization between docker and the host system.
alias ftd='docker run -it --rm --privileged --pid=host debian nsenter -t 1 -m -u -n -i date -u $(date -u +%m%d%H%M%Y)'

function de() {
    docker run -it --rm -v "$(pwd)":/root "env-"$1
}

function dclean() {
    docker container ls -a | awk '{ print $1 }' | grep -v 'CONTAINER' | xargs docker container rm
    docker image ls | grep '<none>' | awk '{ print $3 }' | xargs docker image rm
}
