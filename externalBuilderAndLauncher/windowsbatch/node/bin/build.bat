echo "in build" 1>&2
rem %1, %2, %3
cd %1/src
echo xcopy *.* %3 /s /e 1>&2
xcopy *.* %3 /s /e 1>&2
dir /s %3 1>&2
cd %3
npm install --production 1>&2
