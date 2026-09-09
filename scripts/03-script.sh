#!/bin/bash
fldrList=$(cat /opt/kevrevrun/status/folders.list)
for f in $fldrList; do
    varName=$(echo $f | cut -d ',' -f 1)
    varValue=$(echo $f | cut -d ',' -f 2)
    export $varName="$varValue" 2>&1
done
# Sets the variables for the status files
varFiles=$(cat /opt/kevrevrun/status/files.list)
for v in $varFiles; do
    varName=$(echo $v | cut -d ',' -f 1)
    varValue=$(echo $v | cut -d ',' -f 2)
    export $varName="$varValue"
done
# Reads the values from the files in values.list
valueList=$(cat /opt/kevrevrun/status/values.list)
for v in $valueList; do
    varName=$(echo $v | cut -d ',' -f 1)
    fileName=$(echo $v | cut -d ',' -f 2)
    varValue=$(cat $fileName)
    export $varName="$varValue"
done
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > $tmpDir/rustup.sh
chmod +x $tmpDir/rustup.sh
$tmpDir/rustup.sh -y
source $HOME/.cargo/env
cargo install just
