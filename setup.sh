#!/bin/bash
setupStg=$(cat /opt/kevrevrun/status/setup.stage)
stage1 () {

}
stage2 () {

}
case $setupStg in
    "0")
    stage1
        ;;
    "1")
    stage2
        ;;
esac
