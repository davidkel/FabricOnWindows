rem remove existing artifacts, or proceed on if the directories don't exist
rd /q /s .\channel-artifacts
rd /q /s .\crypto-config
rd /q /s .\data

rem look for binaries in local dev environment /build/bin directory and then in local samples /bin directory
set OPATH=%PATH% 
set PATH=fabric-package\bin;%PATH%

echo "Generating MSP certificates using cryptogen tool"
cryptogen generate --config=cryptogen\crypto-config.yaml

rem set FABRIC_CFG_PATH to configtx.yaml directory that contains the profiles
set FABRIC_CFG_PATH=.\configtx

echo "Generating orderer genesis block"
configtxgen -profile TwoOrgsOrdererGenesis -channelID test-system-channel-name -outputBlock channel-artifacts\genesis.block

echo "Generating channel create config transaction"
configtxgen -channelID mychannel -outputCreateChannelTx channel-artifacts\mychannel.tx -profile TwoOrgsChannel

echo "Generating anchor peer update transaction for Org1"
configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate channel-artifacts\Org1MSPanchors.tx -channelID mychannel -asOrg Org1MSP

echo "Generating anchor peer update transaction for Org2"
configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate channel-artifacts\Org2MSPanchors.tx -channelID mychannel -asOrg Org2MSP

set PATH=%OPATH%