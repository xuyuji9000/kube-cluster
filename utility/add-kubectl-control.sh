#!/bin/sh

# $1 is kubernetes cluster master public ip
if [ -z $1 ]
then
    echo "Does not add parameter."; exit 1;
fi

KUBE_CONFIG="${HOME}/.kube/config"
REMOTE_USER_PATH="/root"

ssh root@$1 "cat ${REMOTE_USER_PATH}/.kube/config" >> $KUBE_CONFIG
