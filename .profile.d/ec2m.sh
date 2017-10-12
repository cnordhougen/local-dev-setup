# Stops ec2metadata if it's already running, then starts it up.
# Assumes its docker conainer has been built already.
# Does the time synchronization fix, so no need to run 'ftd' from docker.sh module beforehand.
function ec2m() {
    docker ps | grep ec2metadata | awk '{ print $1 }' | xargs docker stop
    if [ "$1" != "stop" ]; then
        docker run -it --rm --privileged --pid=host debian nsenter -t 1 -m -u -n -i date -u $(date -u +%m%d%H%M%Y)
        cd ~/Documents/Code/ec2metadata-role-assumption
        docker run -d -e RACK_ENV=production --rm -p 127.0.0.1:8009:4567 -v `ls -d ~/.aws`:/root/.aws ec2metadata
        cd -
    fi
}
