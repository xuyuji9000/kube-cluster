#!/bin/sh

# $1 : action name
if [ -z $1 ]
then
    echo "Does not add parameter."; exit 1;
fi

export ANSIBLE_HOST_KEY_CHECKING=False

if [ $1 = test ]
then
    ansible all -m ping -i hosts
elif [ $1 = join ]
then
    ansible-playbook -i hosts workers.yml
else
    echo 'Does not recognize the command.'
fi
