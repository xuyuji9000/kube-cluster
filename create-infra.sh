#!/bin/sh

# Get digitalocean token
export TF_VAR_do_token=$(cat ~/.config/doctl/config.yaml | grep token | awk '{print $2}')
echo  $(cat ~/.config/doctl/config.yaml | grep token | awk '{print $2}')


# provions servers
terraform apply