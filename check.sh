HOST=${1:-0.0.0.0}
PORT=${2:-8888}
CORRECT_HASH=7bf1979ced70ff367d42a21eead92c82e645f802de327fdabea0ca24f8365b3a
NUM_PASS=0
GREEN_PREFIX="\033[32;1m"
RED_PREFIX="\033[31;1m"
SUFFIX="\033[0m"

echo
echo "(1/2) Checking nodeos Version..."
v=`nodeos -v | awk '{split($0, v, "-"); print v[1]}'`
if [ "$v" == "v1.8.1" ] || [ "$v" == "v1.8.2" ];
then
    echo -e "$GREEN_PREFIX PASS:) nodeos Version Check Passed!$SUFFIX"
    NUM_PASS=$((NUM_PASS + 1))
else
    echo -e "$RED_PREFIX FAIL!! nodeos Version Check Failed!$SUFFIX"
    echo -e "Correct Version is: $GREEN_PREFIX v1.8.1 $SUFFIX OR $GREEN_PREFIX v1.8.2$SUFFIX"
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
fi

echo
if [ $NUM_PASS == 2 ]
then
    echo -e "$GREEN_PREFIX Result: You have passed all checks, good to go!$SUFFIX"
else
    echo -e "$RED_PREFIX Result: You have failed one or more checks, please fix it asap!$SUFFIX"
fi
