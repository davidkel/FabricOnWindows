set OPATH=%PATH%
set PATH=.\fabric-package\bin;%PATH%
set FABRIC_CFG_PATH=.\fabric-package\config

set FABRIC_LOGGING_SPEC=INFO
set CORE_PEER_TLS_ENABLED=true
set CORE_PEER_TLS_ROOTCERT_FILE=..\..\crypto-config\peerOrganizations\org1.example.com\peers\peer0.org1.example.com\tls\ca.crt
set CORE_PEER_ADDRESS=127.0.0.1:7051
set CORE_PEER_LOCALMSPID=Org1MSP
set CORE_PEER_MSPCONFIGPATH=..\..\crypto-config\peerOrganizations\org1.example.com\users\Admin@org1.example.com\msp

rem peer lifecycle chaincode package basic.tar.gz --path ..\asset-transfer-basic\chaincode-go --lang golang --label basic_1

rem install to org 1 peer
peer lifecycle chaincode install prepacked-chaincode\basic.tar.gz

rem install to org 2 peer
set CORE_PEER_TLS_ROOTCERT_FILE=..\..\crypto-config\peerOrganizations\org2.example.com\peers\peer0.org2.example.com\tls\ca.crt
set CORE_PEER_ADDRESS=127.0.0.1:7055
set CORE_PEER_LOCALMSPID=Org2MSP
set CORE_PEER_MSPCONFIGPATH=..\..\crypto-config\peerOrganizations\org2.example.com\users\Admin@org2.example.com\msp
peer lifecycle chaincode install prepacked-chaincode\basic.tar.gz

rem create the CC_PACKAGE_ID (why is it basic_1.0 ?) get this wrong and you get chaincode is not installed
@echo off
for /f "usebackq skip=1 tokens=*" %%i in (`certutil -hashfile prepacked-chaincode\basic.tar.gz sha256`) do (
  set CC_PACKAGE_ID=basic_1.0:%%~i
  goto :done
)
:done
@echo on

rem certutil -hashfile basic.tar.gz sha256


rem CertUtil [Options] -hashfile InFile [HashAlgorithm]
rem SHA256 hash of FirefoxPortable.exe:
rem 7b92ea1a419593ab18490e1e1cbca66fb0d1929d3196b56b4e5bf47dc3303777
rem CertUtil: -hashfile command completed successfully.

rem approve on org2 
peer lifecycle chaincode approveformyorg -o 127.0.0.1:6050 --channelID mychannel --name basic --version 1 --package-id %CC_PACKAGE_ID% --sequence 1 --tls --cafile ..\..\crypto-config\ordererOrganizations\example.com\orderers\orderer.example.com\tls\ca.crt

set CORE_PEER_TLS_ROOTCERT_FILE=..\..\crypto-config\peerOrganizations\org1.example.com\peers\peer0.org1.example.com\tls\ca.crt
set CORE_PEER_ADDRESS=127.0.0.1:7051
set CORE_PEER_LOCALMSPID=Org1MSP
set CORE_PEER_MSPCONFIGPATH=..\..\crypto-config\peerOrganizations\org1.example.com\users\Admin@org1.example.com\msp
rem approve on org1
peer lifecycle chaincode approveformyorg -o 127.0.0.1:6050 --channelID mychannel --name basic --version 1 --package-id %CC_PACKAGE_ID% --sequence 1 --tls --cafile ..\..\crypto-config\ordererOrganizations\example.com\orderers\orderer.example.com\tls\ca.crt


rem commit request sent by org2
peer lifecycle chaincode commit -o 127.0.0.1:6050 --channelID mychannel --name basic --version 1 --sequence 1 --tls --cafile ..\..\crypto-config\ordererOrganizations\example.com\orderers\orderer.example.com\tls\ca.crt