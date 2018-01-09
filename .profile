for PROFILE_SCRIPT in $( ls ~/.profile.d/*.sh ); do
  . $PROFILE_SCRIPT
done

alias ls='ls -pFh'
alias sume="sudo echo 'OK'"

JVM_PATH=/Library/Java/JavaVirtualMachines/
export JAVA_HOME=$JVM_PATH$(ls -1t $JVM_PATH | tail -n1)Contents/Home
PATH="/Users/cnordhougen/android-sdk-macosx/platform-tools:$PATH"

# Setting PATH for Python 3.6
# The original version is saved in .profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
