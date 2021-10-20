echo "In Run" 1>&2
@echo off
for /f "usebackq tokens=*" %%i in (`jq-win64 -r .chaincode_id %2\chaincode.json`) do (
  set CORE_CHAINCODE_ID_NAME=%%~i
  goto :done
)
:done

for /f "usebackq tokens=*" %%i in (`jq-win64 -r .mspid %2\chaincode.json`) do (
  set CORE_PEER_LOCALMSPID=%%~i
  goto :done
)
:done

for /f "usebackq tokens=*" %%i in (`jq-win64 -r .peer_address %2\chaincode.json`) do (
  set PEER_ADDRESS=%%~i
  goto :done
)
:done
echo %cd% 1>&2

set CORE_PEER_TLS_ENABLED=true
rem it's PATH not FILE for node chaincode whereas Go Chaincode supports both

set CORE_TLS_CLIENT_CERT_PATH_PEM=%2\client.crt
set CORE_TLS_CLIENT_KEY_PATH_PEM=%2\client.key
set CORE_TLS_CLIENT_CERT_PATH=%2\client.b64
set CORE_TLS_CLIENT_KEY_PATH=%2\key.b64
set CORE_PEER_TLS_ROOTCERT_FILE=%2\root.crt


echo "About to run jq" 1>&2

jq-win64 -r .client_cert %2\chaincode.json | base64 -w 0 > %CORE_TLS_CLIENT_CERT_PATH%
jq-win64 -r .client_key %2\chaincode.json | base64 -w 0 > %CORE_TLS_CLIENT_KEY_PATH%
jq-win64 -r .root_cert  %2\chaincode.json > %CORE_PEER_TLS_ROOTCERT_FILE%

rem echo "About to run certutil 1" 1>&2
rem echo certutil -encode %CORE_TLS_CLIENT_CERT_PATH_PEM% %2\tmp1.b64 && findstr /v /c:- %2\tmp1.b64 1>&2

rem certutil -encode %CORE_TLS_CLIENT_CERT_PATH_PEM% %2\tmp1.b64 && findstr /v /c:- %2\tmp1.b64 > %CORE_TLS_CLIENT_CERT_PATH%

rem echo "About to run certutil 2" 1>&2
rem certutil -encode %CORE_TLS_CLIENT_KEY_PATH_PEM% %2\tmp2.b64 && findstr /v /c:- %2\tmp2.b64 > %CORE_TLS_CLIENT_KEY_PATH%

echo "CERT" 1>&2
type %CORE_TLS_CLIENT_CERT_PATH% 1>&2
echo "KEY" 1>&2
type %CORE_TLS_CLIENT_KEY_PATH% 1>&2
echo "ROOT" 1>&2
type %CORE_PEER_TLS_ROOTCERT_FILE% 1>&2

type %2\chaincode.json 1>&2

dir %2 1>&2


@echo on
set 1>&2
cd %1
echo %1 1>&2
echo %2 1>&2
npm start -- --peer.address=%PEER_ADDRESS% 1>&2