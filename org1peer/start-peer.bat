set OPATH=%PATH%
set PATH=..\fabric-package\bin;%PATH%
set FABRIC_CFG_PATH=..\fabric-package\config

set FABRIC_LOGGING_SPEC=debug:cauthdsl,policies,msp,grpc,peer.gossip.mcs,gossip,leveldbhelper=info
set CORE_PEER_TLS_ENABLED=true
set CORE_PEER_TLS_CERT_FILE=..\..\crypto-config\peerOrganizations\org1.example.com\peers\peer0.org1.example.com\tls\server.crt
set CORE_PEER_TLS_KEY_FILE=..\..\crypto-config\peerOrganizations\org1.example.com\peers\peer0.org1.example.com\tls\server.key
set CORE_PEER_TLS_ROOTCERT_FILE=..\..\crypto-config\peerOrganizations\org1.example.com\peers\peer0.org1.example.com\tls\ca.crt
set CORE_PEER_ID=peer0.org1.example.com
set CORE_PEER_ADDRESS=127.0.0.1:7051
set CORE_PEER_LISTENADDRESS=127.0.0.1:7051
set CORE_PEER_CHAINCODEADDRESS=127.0.0.1:7052
set CORE_PEER_CHAINCODELISTENADDRESS=127.0.0.1:7052
rem bootstrap peer is myself
set CORE_PEER_GOSSIP_BOOTSTRAP=127.0.0.1:7051
set CORE_PEER_GOSSIP_EXTERNALENDPOINT=127.0.0.1:7051
set CORE_PEER_LOCALMSPID=Org1MSP
set CORE_PEER_MSPCONFIGPATH=..\..\crypto-config\peerOrganizations\org1.example.com\peers\peer0.org1.example.com\msp
set CORE_OPERATIONS_LISTENADDRESS=127.0.0.1:8446
set CORE_PEER_FILESYSTEMPATH=..\..\data\peer0.org1.example.com
rem needs to be absolute
rem set CORE_LEDGER_SNAPSHOTS_ROOTDIR=..\..\data\peer0.org1.example.com\snapshots

rem uncomment the lines below to utilize couchdb state database, when done with the environment you can stop the couchdb container with "docker rm -f couchdb1"
rem set CORE_LEDGER_STATE_STATEDATABASE=CouchDB
rem set CORE_LEDGER_STATE_COUCHDBCONFIG_COUCHDBADDRESS=127.0.0.1:5984
rem set CORE_LEDGER_STATE_COUCHDBCONFIG_USERNAME=admin
rem set CORE_LEDGER_STATE_COUCHDBCONFIG_PASSWORD=password
rem docker run --publish 5984:5984 --detach -e COUCHDB_USER=admin -e COUCHDB_PASSWORD=password --name couchdb1 couchdb:3.1.1

rem setup an external builder
set CORE_CHAINCODE_EXTERNALBUILDERS=[{name: windows-batch-node, path: ..\externalBuilderAndLauncher\windowsbatch\node}]

rem start peer
peer node start
set PATH=%OPATH%
