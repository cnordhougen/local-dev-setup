function clean() {
    TYPES=$(echo $2 | sed -e 's/,/\|/g')
    find -E $1 -regex ".*\.("$TYPES")$" | xargs rm
}
