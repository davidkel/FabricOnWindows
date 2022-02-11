# FabricOnWindows

test-env is where microfab runs outside of docker
need to create a bin and config dir with contents of binaries packages
need to create a builders directory with golang/node/java/external subdirs with the appropriate external builders in place
data for each node is created in the working dir under the node's dir in the data directory which contains both config to read and where data will be written

Currently couchdb is defaulted to not used as you need to have an instance of couchdb running


## Native Fabric in WSL 1

this uses network-test-nano-bash

```bash
export CORE_CHAINCODE_EXTERNALBUILDERS='[{name: linux-shell-node, path: ../../../mine/linux-external-builders/bash/node}, {name: linux-shell-go, path: ../../../mine/linux-external-builders/bash/go}]'
```

### org1admin.sh

```bash
#!/usr/bin/env bash

# look for binaries in local dev environment /build/bin directory and then in local samples /bin directory
export PATH="${PWD}"/../../fabric/build/bin:"${PWD}"/../bin:"$PATH"
export FABRIC_CFG_PATH="${PWD}"/../config

export FABRIC_LOGGING_SPEC=INFO
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_TLS_ROOTCERT_FILE="${PWD}"/crypto-config/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_ADDRESS=127.0.0.1:7051
export CORE_PEER_LOCALMSPID=Org1MSP
export CORE_PEER_MSPCONFIGPATH="${PWD}"/crypto-config/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
```

use the linux external builders package
