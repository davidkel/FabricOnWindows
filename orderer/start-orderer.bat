set OPATH=%PATH%
set PATH=..\fabric-package\bin;%PATH%
set FABRIC_CFG_PATH=..\fabric-package\config

set FABRIC_LOGGING_SPEC=debug:cauthdsl,policies,msp,common.configtx,common.channelconfig=info
set ORDERER_GENERAL_LISTENPORT=6050
set ORDERER_GENERAL_LOCALMSPID=OrdererMSP
rem relative to the CFG_PATH
set ORDERER_GENERAL_LOCALMSPDIR=..\..\crypto-config\ordererOrganizations\example.com\orderers\orderer.example.com\msp
set ORDERER_GENERAL_TLS_ENABLED=true
set ORDERER_GENERAL_TLS_PRIVATEKEY=..\..\crypto-config\ordererOrganizations\example.com\orderers\orderer.example.com\tls\server.key
set ORDERER_GENERAL_TLS_CERTIFICATE=..\..\crypto-config\ordererOrganizations\example.com\orderers\orderer.example.com\tls\server.crt
rem following setting is not really needed at runtime since channel config has ca root certs, but we need to override the default in orderer.yaml
set ORDERER_GENERAL_TLS_ROOTCAS=..\..\crypto-config\ordererOrganizations\example.com\orderers\orderer.example.com\tls\ca.crt
set ORDERER_GENERAL_BOOTSTRAPMETHOD=file
set ORDERER_GENERAL_BOOTSTRAPFILE=..\..\channel-artifacts\genesis.block
set ORDERER_FILELEDGER_LOCATION=..\..\data\orderer
rem these paths are not off the FABRIC_CFG_PATH
set ORDERER_CONSENSUS_WALDIR=..\data\orderer\etcdraft\wal
set ORDERER_CONSENSUS_SNAPDIR=..\data\orderer\etcdraft\wal
set ORDERER_OPERATIONS_LISTENADDRESS=127.0.0.1:8443
set ORDERER_ADMIN_LISTENADDRESS=127.0.0.1:9443

rem start orderer
orderer
set PATH=%OPATH%