#Variables & Status Files

## Directories

1. /opt/kevrevrun
	- CFG_DIR
2. /opt/kevrevrun/repos
	- DEB_DIR
3. /opt/kevrevrun/status
	- RUN_DIR
4. /opt/kevrevrun/setup
	- SET_DIR	
5. /opt/kevrevrun/scripts
	- SCR_DIR
6. /opt/kevrevrun/configs
	- NFO_DIR

# Status Files

1. id.usr
	- in CFG_DIR
	- Created in initial.sh
	- Var: USR_ID
2. name.usr
	- in CFG_DIR
	- Created in initial.sh
	- Var: USR_NM
3. loop.status
	- in RUN_DIR
	- Created in setup.sh
	- Var: STATUS
4. install.dir
	- in RUN_DIR
	- Created in setup.sh 
	- Var: IST_DIR
5. center.value
	- in RUN_DIR
	- Created in setup.sh
	- Var: CENTER
6. margin.value
	- in RUN_DIR
	- Created in setup.sh
	- Var: MARGIN
7. left.value
	- in RUN_DIR
	- Created in setup.sh
	- Var: $LEFT
8. setup.stage
	- in RUN_DIR
	- Created in setup.sh
	- STAGE

# Temporary Files

1. title.tmp
	- Stored in IST_DIR
	- Stores double lines box text
2. output.tmp
	- Stored in IST_DIR
	- Stores APT output

# Variables

1. CFG_DIR=/opt/kevrevrun
2. USR_ID=$(cat $CFG_DIR/id.usr)
3. USR_NM=$(cat $CFG_DIR/name.usr)
4. IST_DIR=$(cat $CFG_DIR/install.dir)
5. CENTER=$(cat $RUN_DIR/center.value)
6. MARGIN=$(cat $RUN_DIR/margin.value)
7. LEFT=$(cat $RUN_DIR/left.value)
8. STATUS=$(cat $RUN_DIR/loop.status)
9. $STAGE=$(cat $RUN_DIR/setup.stage)
