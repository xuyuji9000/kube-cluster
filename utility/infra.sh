#!/bin/sh

if [ -z $1 ]
then
    echo "Does not add parameter."; exit 1;
fi

# Get digitalocean token
export TF_VAR_do_token=$(cat ~/.config/doctl/config.yaml | grep token | awk '{print $2}')
export ANSIBLE_HOST_KEY_CHECKING=False
# echo  $(cat ~/.config/doctl/config.yaml | grep token | awk '{print $2}')


if [ $1 = "apply" ]
then

    terraform apply

elif [ $1 = "server" ]
then

    doctl compute droplet list --format Name,PublicIPv4

elif [ $1 = "test" ]
then

    ansible all -m ping -i hosts

elif [ $1 = join ]
then

    ansible-playbook -i hosts workers.yml

elif [ $1 = "destroy" ]
then

    terraform destroy

else
    echo 'Does not recognize the command.'
fi
