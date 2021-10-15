set OPATH=%PATH%
set PATH=.\fabric-package\bin;%PATH%
set FABRIC_CFG_PATH=.\fabric-package\config

set FABRIC_LOGGING_SPEC=INFO
set CORE_PEER_TLS_ENABLED=true
set CORE_PEER_TLS_ROOTCERT_FILE=..\..\crypto-config\peerOrganizations\org1.example.com\peers\peer0.org1.example.com\tls\ca.crt
set CORE_PEER_ADDRESS=127.0.0.1:7051
set CORE_PEER_LOCALMSPID=Org1MSP
set CORE_PEER_MSPCONFIGPATH=..\..\crypto-config\peerOrganizations\org1.example.com\users\Admin@org1.example.com\msp

rem peer0 org1 admin will be responsible for creating channel and adding anchor peer
peer channel create -c mychannel -o 127.0.0.1:6050 -f .\channel-artifacts\mychannel.tx --outputBlock .\channel-artifacts\mychannel.block  --tls --cafile ..\..\crypto-config\ordererOrganizations\example.com\orderers\orderer.example.com\tls\ca.crt
peer channel update -o 127.0.0.1:6050 -c mychannel -f .\channel-artifacts\Org1MSPanchors.tx --tls --cafile ..\..\crypto-config\ordererOrganizations\example.com\orderers\orderer.example.com\tls\ca.crt

rem join peer to channel
peer channel join -b .\channel-artifacts\mychannel.block


set CORE_PEER_TLS_ROOTCERT_FILE=..\..\crypto-config\peerOrganizations\org2.example.com\peers\peer0.org2.example.com\tls\ca.crt
set CORE_PEER_ADDRESS=127.0.0.1:7055
set CORE_PEER_LOCALMSPID=Org2MSP
set CORE_PEER_MSPCONFIGPATH=..\..\crypto-config\peerOrganizations\org2.example.com\users\Admin@org2.example.com\msp

rem join peer to channel
peer channel join -b .\channel-artifacts\mychannel.block

set PATH=%OPATH%