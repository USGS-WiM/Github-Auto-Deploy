#!/bin/sh

main() {
  autoDeployStatus $@
}

autoDeployStatus() {
  
  # check NWIS mapper exporter
  isExp=`ps -ef|grep export.py|grep python`
  if [ -z "$isExp" ] ; then
	/usr/bin/nohup python /opt/Github-Auto-Deploy/GitAutoDeploy.py > /dev/null 2>&1 &
  fi
}

main $@


