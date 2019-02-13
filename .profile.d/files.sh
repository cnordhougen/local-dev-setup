# Delete files by type
function rm_types() {
    if [ "${1}" == "--dry-run" ]; then
        IS_DRY_RUN=1
        LOCATION=$2
        TYPES=$3
    else
        IS_DRY_RUN=0
        LOCATION=$1
        TYPES=$2
    fi

    if [ "${TYPES}" == "" ]; then
        echo 'USAGE:'
        echo 'rm-types [--dry-run] LOCATION COMMA_SEPARATED_TYPES'
        echo '    Find all files, recursively, in LOCATION of the given file types,'
        echo '    and delete them. If the --dry-run option is given, no files will'
        echo '    be deleted and instead the list of files that would be deleted will'
        echo '    be printed out.'
        echo ''
        echo 'EXAMPLE:'
        echo 'rm-types ./foo bak,log'
    else
        TYPES=$(echo $TYPES | sed -e 's/, ?/\|/g')
        for f in $(find -E $1 -regex ".*\.("$TYPES")$"); do
            if $IS_DRY_RUN; then
                echo "Dry run: Would delete ${f}"
            else
                rm $f
                echo "Deleted: ${f}"
            fi
        done
    fi
}

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
