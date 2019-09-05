# EOSIO 1.8 Checker

This script is used for EOS Block Producers to check if their producing node is ready for 1.8.x upgrade.

# Usage


In order to use this script, make sure you have enabled producer api plugin on your producing node. Also, make sure `curl` is installed.

This script checks two things, nodeos version and protocal feature hash.

Valid nodeos version should be `v1.8.1` OR `v1.8.2`.

Valid protocal feature hash should be `7bf1979ced70ff367d42a21eead92c82e645f802de327fdabea0ca24f8365b3a`, you can double check it using(change `$PORT` and `$HOST` accordingly):

```
curl -s -X POST http://$HOST:$PORT/v1/producer/get_supported_protocol_features -d '{}' | sha256sum | awk '{print $1}'
```

To use this tool, if your node is accessible via `localhost` on port `8888`, just run:

```
./check.sh
```

or you can specify `Host` and `Port` like this:

```
./check.sh xx.xx.xx.xx 8877
```

If all checks pass, the output would be like this:

  <img src="./Success.png">

otherwise:

  <img src="./Fail.png">

