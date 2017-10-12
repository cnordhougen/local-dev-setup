# Load git completion & add git command aliases

test -f ~/.git-completion.bash && . $_


function gb() {
    git branch $1
    git checkout $1
    git push -u origin $1
}

function gc() {
    git add .
    git commit -m "$1"
    git push
}

alias gp='git push -f'
alias gr='git rebase master;git push'
alias gs='git status'
alias gdu='git status|grep '"'"'\t'"'"'|awk '"'"'{ print $1 }'"'"'|xargs rm -rf'

function gu() {
    UPSTREAM=$(git remote|grep 'upstream')
    if [ "$UPSTREAM" != '' ]; then
        git fetch upstream
        git rebase -i upstream/master
    else
        git pull
    fi
}
