set OPATH=%PATH%
set PATH=.\fabric-package\bin;%PATH%
set FABRIC_CFG_PATH=.\fabric-package\config

set FABRIC_LOGGING_SPEC=INFO
set CORE_PEER_TLS_ENABLED=true
set CORE_PEER_TLS_ROOTCERT_FILE=..\..\crypto-config\peerOrganizations\org1.example.com\peers\peer0.org1.example.com\tls\ca.crt
set CORE_PEER_ADDRESS=127.0.0.1:7051
set CORE_PEER_LOCALMSPID=Org1MSP
set CORE_PEER_MSPCONFIGPATH=..\..\crypto-config\peerOrganizations\org1.example.com\users\Admin@org1.example.com\msp

peer chaincode invoke

peer chaincode invoke -o 127.0.0.1:6050 -C mychannel -n basic -c {\"Args\":[\"createChaosAsset\",\"c1\",\"99\"]} --tls --cafile "../../crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt" --waitForEvent
set FNARGS={\"Args\":[\"readChaosAsset\",\"c1\"]}
peer chaincode query -C mychannel -n basic -c %FNARGS%

peer chaincode invoke -o 127.0.0.1:6050 -C mychannel -n basic -c {\"Args\":[\"updateChaosAsset\",\"c1\",\"65\"]} --tls --cafile "../../crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt" --waitForEvent

peer chaincode query -C mychannel -n basic -c %FNARGS%