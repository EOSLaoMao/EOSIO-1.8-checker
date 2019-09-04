# EOSIO 1.8 Checker

This script is used for EOS Block Producers to check if there producing node is ready for 1.8.x upgrade.

# Usage


In order to use this script, make you have enabled producer api plugin on your producing node. Also, make sure `curl` is installed.

This script checks two things, nodeos version and protocal feature hash.

if your node is accessible via localhost on port 8888, just run:

```
./check.sh
```

or you can specify host and port like this:

```
./check.sh xx.xx.xx.xx 8877
```

If you passed both checks, the output would be like this:

  <img src="./Success.png">

otherwise:

  <img src="./Fail.png">



