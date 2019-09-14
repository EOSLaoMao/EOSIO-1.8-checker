#!/bin/bash

HOST=${1:-127.0.0.1}
PORT=${2:-8888}
CORRECT_HASH=7bf1979ced70ff367d42a21eead92c82e645f802de327fdabea0ca24f8365b3a
ACTIVATION_TIME=2019-09-23T13:00:00.000
NUM_PASS=0
GREEN_PREFIX="\033[32;1m"
RED_PREFIX="\033[31;1m"
SUFFIX="\033[0m"

echo
echo "(1/2) Checking nodeos Version..."
v=`nodeos -v | awk '{split($0, v, "-"); print v[1]}'`
if [ "$v" == "v1.8.1" ] || [ "$v" == "v1.8.2" ] || [ "$v" == "v1.8.3" ];
then
    echo -e "$GREEN_PREFIX PASS:) nodeos Version Check Passed!$SUFFIX"
    NUM_PASS=$((NUM_PASS + 1))
else
    echo -e "$RED_PREFIX FAIL!! nodeos Version Check Failed!$SUFFIX"
    echo -e "Correct Version is: $GREEN_PREFIX v1.8.1 $SUFFIX , $GREEN_PREFIX v1.8.2$SUFFIX OR $GREEN_PREFIX v1.8.3$SUFFIX"
    echo -e "Your Version is:    $RED_PREFIX $v $SUFFIX"
fi

echo
echo "(2/2)Checking Protocal Features Hash..."
hash=`curl -s -X POST http://$HOST:$PORT/v1/producer/get_supported_protocol_features -d '{}' | sha256sum | awk '{print $1}'`


if [ $hash == $CORRECT_HASH ];
then
    echo -e "$GREEN_PREFIX PASS:) Protocal Features Hash Check Passed!$SUFFIX"
    NUM_PASS=$((NUM_PASS + 1))
else
    echo -e "$RED_PREFIX FAIL!! Protocal Features Hash Check Failed!$SUFFIX"
    echo -e "Correct hash is: $GREEN_PREFIX $CORRECT_HASH $SUFFIX"
    echo -e "Your hash is:    $RED_PREFIX $hash $SUFFIX"
    echo
    echo -e " Verify the following:"
    echo -e "  1) earliest_allowed_activation_time is set to $GREEN_PREFIX$ACTIVATION_TIME$SUFFIX in BUILTIN-PREACTIVATE_FEATURE.json"
    echo -e "  2)$GREEN_PREFIX producer_api_plugin$SUFFIX is enabled"
fi

echo
if [ $NUM_PASS == 2 ]
then
    echo -e "$GREEN_PREFIX Result: You have passed all checks, good to go!$SUFFIX"
else
    echo -e "$RED_PREFIX Result: You have failed one or more checks, please fix it and try again!$SUFFIX"
fi
