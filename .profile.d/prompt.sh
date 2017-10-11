function opt_u_h() {
    U=$(whoami)
    H=$(hostname)
    if [ "$U" != 'nordhougen' -o "$H" != 'MSP-CNOR' ]; then
        printf "\e[1;36m$U@$H\e[1;39m:\e[0m"
    fi
}

function get_git_branch() {
    BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \([^ ]*\)/\1/' -e 's/(HEAD detached at \([^)]*\))/\1/')
    if [ "$BRANCH" != '' ]; then
	    printf "\e[1;39m@\e[35m$BRANCH\e[0m"
    fi
}

function get_git_status() {
    STATUS=$(git status 2>&1 | grep -iE 'nothing to commit|not a git repo' | wc -l | sed -e 's/^[ \t]*//' -e 's/1//' -e 's/0/*/')
    if [ '$(get_git_branch)' != '' ]; then
	    printf "$STATUS"
    fi
}

export PS1='[\A] $(opt_u_h)\[\e[1;33m\]\w\e\[\e[m\]$(get_git_branch)\[\033[0m\]$(get_git_status)\n $ '
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
