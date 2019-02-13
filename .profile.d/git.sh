# Load git completion & add git command aliases

test -f ~/.git-completion.bash && . $_

alias gcwb='git status|grep "On branch"|grep -Eo "[^ ]+$"'
alias gs='git status'
alias gdu='git status|grep '"'"'\t'"'"'|awk '"'"'{ print $1 }'"'"'|xargs rm -rf'
alias gbls='git branch -l'
alias grc='git add . && git rebase --continue'
alias gca='git add . && git commit --amend --no-edit && git push -f'

function gb() {
    REF=$2
    if [[ ! $REF ]]; then
        REF=HEAD
    fi
    
    git checkout $2 -b $1
    git push -u origin $1
}

gbrm() {
    BRANCH=$1
    if [[ ! $BRANCH ]]; then
        BRANCH=$(gcwb)
    fi

    CUR_BRANCH=$(gcwb)

    if [[ $BRANCH == $CUR_BRANCH ]]; then
        git checkout master
    fi

    git branch -D $BRANCH
    git push origin --delete $BRANCH
}

gbc() {
    for branch in $(git branch|grep -v '*'|grep -v 'master'); do
        gbrm $branch
    done
}

function gc() {
    git add .
    git commit -m "$1"
    git push
}

function gu() {
    if [[ ! $(git status|grep 'nothing to commit, working tree clean') ]]; then
        echo "Please commit or stash your local changes first."
        return
    fi

    BRANCH=$(gcwb)
    if [[ $BRANCH != master ]]; then
        git checkout master
    fi

    REMOTE=origin
    if [[ $(git remote|grep 'upstream') ]]; then
        REMOTE=upstream
    fi

    git pull $REMOTE master --rebase=interactive
    CUR_BRANCH=$(gcwb)
    if [[ $CUR_BRANCH ]]; then
        git push -f
        if [[ $BRANCH != master ]]; then
            git checkout $BRANCH
            git rebase -i master
            CUR_BRANCH=$(gcwb)
            if [[ $CUR_BRANCH ]]; then
                git push -f
            fi
        fi
    fi
}
