#!/bin/sh

# Get digitalocean token
export TF_VAR_do_token=$(cat ~/.config/doctl/config.yaml | grep token | awk '{print $2}')
# echo  $(cat ~/.config/doctl/config.yaml | grep token | awk '{print $2}')


if [ $1 = apply ]
then
# provions servers
    terraform apply
elif [ $1 = destroy ]
then
    terraform destroy
else
    echo 'Does not recognize the command.'
fi
