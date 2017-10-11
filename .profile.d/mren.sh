function mren() {
    FIND_REGEX=$1
    REN_REGEX=$2

    if [ "$1" == "--dry-run" ]; then
        FIND_REGEX=$2
        REN_REGEX=$3
    fi

    for f in $(find -E . -regex $FIND_REGEX); do
        fnew=$(echo $f | sed -e $REN_REGEX)
        if [ "$1" != "--dry-run" ]; then
            mv $f $fnew
        fi
        echo $f" -> "$fnew
    done
}
