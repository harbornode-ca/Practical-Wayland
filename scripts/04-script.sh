echo
echo "Setting up Folder Variables"
echo
sleep 1
fldrList=$(cat /opt/kevrevrun/status/folders.list)
for f in $fldrList; do
    varName=$(echo $f | cut -d ',' -f 1)
    varValue=$(echo $f | cut -d ',' -f 2)
    export $varName="$varValue" 2>&1
    echo "Folder Variable $varName is set to $varValue"
    sleep 0.25
done
echo
echo
echo "Setting up File Variables"
sleep 1
echo
varFiles=$(cat /opt/kevrevrun/status/files.list)
for v in $varFiles; do
    varName=$(echo $v | cut -d ',' -f 1)
    varValue=$(echo $v | cut -d ',' -f 2)
    export $varName="$varValue"
    echo "File Variable $varName is set to $varValue"
    sleep 0.25
done
echo
echo "Reading and Exporting All Setup Variables"
sleep 1
echo
valueList=$(cat /opt/kevrevrun/status/values.list)
for v in $valueList; do
    varName=$(echo $v | cut -d ',' -f 1)
    fileName=$(echo $v | cut -d ',' -f 2)
    varValue=$(cat $fileName)
    export $varName="$varValue"
    echo "Variable $varName has been imported with value $varValue"
    sleep 0.25
done
# Checking for system GPU types using lspci
intelGPU=$(lspci | grep -i vga | grep -i "Intel")
amdGPU=$(lspci | grep -i vga | grep -i "AMD")
nvidiaGPU=$(lspci | grep -i vga | grep -i "NVIDIA")

if [ -n "$intelGPU" ]; then
    echo "Intel GPU detected"
    echo "The following Intel GPUs detected:
    cat $intelGPU
    
elif [ -n "$amdGPU" ]; then
    echo "AMD GPU detected"
    echo "The following AMD GPUs detected:
    cat $amdGPU
    
elif [ -n "$nvidiaGPU" ]; then
    echo "NVIDIA GPU detected"
    echo "The following NVIDIA GPUs detected:
    cat $nvidiaGPU
    
else
    echo "No GPU detected"
fi
