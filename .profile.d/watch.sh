function watch() {
    while :; do
        clear
        date
        bash -c "$1"
        sleep ${2:-1}
    done
}
