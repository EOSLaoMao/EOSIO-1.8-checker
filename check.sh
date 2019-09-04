HOST=${1:-0.0.0.0}
PORT=${2:-8888}
CORRECT_HASH=5cfc758bcc11edadcb5f3c6717c22fe610ffdd8d5bd2441d3a1e4c2923e5f230
NUM_PASS=0

echo
echo "(1/2) Checking nodeos Version..."
v=`nodeos -v | awk '{split($0, v, "-"); print v[1]}'`
if [ "$v" == "v1.8.1" ] || [ "$v" == "v1.8.2" ];
then
    echo -e "\033[32;1mPASS:) nodeos Version Check Passed!\033[0m"
    NUM_PASS=$((NUM_PASS + 1))
else
    echo -e "\033[31;1mFAIL!! nodeos Version Check Failed!\033[0m"
    echo -e "Correct Version is: \033[32;1mv1.8.1\033[0m OR \033[32;1mv1.8.2\033[0m"
    echo -e "Your Version is:    \033[31;1m$v\033[0m"
fi

echo
echo "(2/2)Checking Protocal Features Hash..."
hash=`curl -s -X POST http://$HOST:$PORT/v1/producer/get_supported_protocol_features -d '{}' | sha256sum | awk '{print $1}'`


if [ $hash == $CORRECT_HASH ];
then
    echo -e "\033[32;1mPASS:) Protocal Features Hash Check Passed!\033[0m"
    NUM_PASS=$((NUM_PASS + 1))
else
    echo -e "\033[31;1mFAIL!! Protocal Features Hash Check Failed!\033[0m"
    echo -e "Correct hash is: \033[32;1m$CORRECT_HASH\033[0m"
    echo -e "Your hash is:    \033[31;1m$hash\033[0m"
fi

echo
if [ $NUM_PASS == 2 ]
then
    echo -e "\033[32;1mResult: You have passed all checks, good to go!\033[0m"
else
    echo -e "\033[31;1mResult: You have failed one or more checks, please fix it asap!\033[0m"
fi
