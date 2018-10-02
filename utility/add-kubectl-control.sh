#!/bin/sh

# $1 is kubernetes cluster master public ip

KUBE_CONFIG="${HOME}/.kube/config"
REMOTE_USER_PATH="/root"

ssh root@$1 "cat ${REMOTE_USER_PATH}/.kube/config" >> $KUBE_CONFIG
