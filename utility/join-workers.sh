#!/bin/sh

# $1 : action name

export ANSIBLE_HOST_KEY_CHECKING=False

if [ $1 = test ]
then
    ansible all -m ping -i hosts
fi
