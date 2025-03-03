#!/usr/bin/env bash
#
# Charon daemon watchdog script - charon-systemd required
# responder has a dynamic ip and static FQDN ( dynamic DNS for example )
# responder ip can change after ISP connection drops and reestablishes
# charon does not re-resolve peer when DPD or retransmit is active
# ver 0.0.0.1
#
# This script needs permissions to /var/run/charon.vici socket
REMOTE=my.remote.fqdn
SWANOUT=$(swanctl --list-sas 2>/dev/null)
ERR=$?
if [ ${ERR}  -ne 0 ];
        then
                echo "Swanctl failed whith error ${ERR}"
                exit
fi
ACTIP=$(echo "${SWANOUT}" | awk -F[\@\[\ ] '/remote/{print $7;exit}')
if [ -z ${ACTIP} ];
        then
                echo "Remote IKE info not available"
                exit
fi
NEWIP=$(dig +short ${REMOTE})
if [ -z ${NEWIP} ];
        then
                echo "Cant resolve remote FQDN"
                exit
fi

# debug info
[[ ${ACTIP} == ${NEWIP} ]] && echo ${ACTIP} ${NEWIP}
if [ ${ACTIP} != ${NEWIP} ];
        then
                echo "Restarting charon daemon to re-resolve remote"
                systemctl restart strongswan.service
fi
