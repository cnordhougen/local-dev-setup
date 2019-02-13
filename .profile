for PROFILE_SCRIPT in $( ls ~/.profile.d/*.sh ); do
  . $PROFILE_SCRIPT
done

JVM_PATH=/Library/Java/JavaVirtualMachines/
export JAVA_HOME=$JVM_PATH$(ls -1t $JVM_PATH | tail -n1)Contents/Home
PATH="$HOME/android-sdk-macosx/platform-tools:$PATH"

PATH="/opt/apache-maven-3.5.3/bin:$PATH"

# Setting PATH for Python 3.6
# The original version is saved in .profile.pysave
# PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:$PATH"

export PATH=$PATH:$HOME/Library/Python/2.7/bin
export POWERLINE_HOME="$HOME/Library/Python/2.7/lib/python/site-packages/powerline"
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. ~/Library/Python/2.7/lib/python/site-packages/powerline/bindings/bash/powerline.sh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export AWS_REGION=us-east-1
export AWS_DEFAULT_REGION=us-east-1
export AWS_PROFILE=dev_account

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
export NODE_ENV=development

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
