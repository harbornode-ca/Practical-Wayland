#!/bin/bash
#Moves files from the dev folder to the main folder
destFldr="/opt/kevrevrun/scripts /opt/kevrevrun/cfg"
for f in $destFldr; do
    echo $f
    rm -rvf $f/*
done
destFldr="/opt/kevrevrun/scripts /opt/kevrevrun/cfg"
for f in $destFldr; do
    srcFldr=$(echo $f | cut -d '/' -f 4)
    cp -Rv $HOME/practical-wayland/$srcFldr/* $f
done
