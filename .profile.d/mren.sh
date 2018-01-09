# Mass file rename
function mren() {
    if [ "$1" == "" ]; then
        echo 'USAGE:'
        echo 'mren [--dry-run] [FIND_REGEX] REN_REGEX'
        echo '    Find all files, recursively, in the current directory matching FIND_REGEX,'
        echo '    and rename them by applying REN_REGEX to each filename (using sed -e).'
        echo '    If the --dry-run option is given the files will not be renamed and instead'
        echo '    a list will be output of what exactly would be done. If no FIND_REGEX is'
        echo '    given, the rename will be applied to all files.'
        echo ''
        echo 'EXAMPLE:'
        echo "mren '.+\.foo$' 's/\.foo$/.bar/' # Rename all .foo files to .bar"
    else
        FIND_REGEX=$1
        REN_REGEX=$2

        if [ "$1" == "--dry-run" ]; then
            FIND_REGEX=$2
            REN_REGEX=$3
        fi

        if [ "$REN_REGEX" == "" ]; then
            REN_REGEX=$FIND_REGEX
            FIND_REGEX=".+"
        fi

        for f in $(find -E . -regex $FIND_REGEX); do
            if [ "$f" != "." ]; then
                fnew=$(echo $f | sed -e $REN_REGEX)
                if [ "$1" != "--dry-run" ]; then
                    mv $f $fnew
                fi
                echo $f" -> "$fnew
            fi
        done
    fi
}
