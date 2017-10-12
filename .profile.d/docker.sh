# Temporarily resolves an issue with time synchronization between docker and the host system.
alias ftd='docker run -it --rm --privileged --pid=host debian nsenter -t 1 -m -u -n -i date -u $(date -u +%m%d%H%M%Y)'
