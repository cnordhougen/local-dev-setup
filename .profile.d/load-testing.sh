function hammer() {
    docker run -it \
        -e "environ=test" \
        -e "IDENTITY_TOKEN=$IDENTITY_TOKEN" \
        -e "SERVICE=$1" \
        -e "REQUEST_PATH=$2" \
        -e "CONCURRENCY=$3" \
        -e "RAMP_UP=$4" \
        -e "HOLD_FOR=$5" \
        -e "VERBOSITY=${6//[^v]/}" \
        --rm bzt
}
