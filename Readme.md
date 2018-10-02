Create a Kubernetes cluster on Digital Ocean with ansible and terraform.

# Setup

1. `./utility/infra.sh apply` creates one master and one worker with firewalls.

2. Create `hosts` file according to `hosts.example`, update master and worker public ip

3. Let worker join the cluster, `ansible-playbook -i hosts workers.yml`

# Destroy

1. `./utility/infra.sh destroy` destroies the provisioned resources.


# Test

SSH into master node, run `kubectl get nodes`, should have result like this:

![image](https://user-images.githubusercontent.com/4877346/45913656-2700af80-be69-11e8-854a-8882bff1de92.png)



# Utilities

## Ansible

- `export ANSIBLE_HOST_KEY_CHECKING=False`

- `ansible all -m ping -i hosts`

## Terraform

- `export DIGITALOCEAN_TOKEN=digitalocean_token`

- `export TF_VAR_do_token=$(cat ~/.config/doctl/config.yaml | grep token | awk '{print $2}')`

## DigitalOcean Cli

- `doctl compute droplet delete -f $(doctl compute droplet list --format Name --no-header)`

- Watch the servers: `watch doctl compute droplet list --format Name,PublicIPv4`


# Reference

1. [How To Create a Kubernetes 1.11 Cluster Using Kubeadm on Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-create-a-kubernetes-1-11-cluster-using-kubeadm-on-ubuntu-18-04)

2. [Install kubeadm](https://kubernetes.io/docs/setup/independent/install-kubeadm/)

3. [Creating a single master cluster with kubeadm](https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/)

4. [csi-digitalocean](https://github.com/digitalocean/csi-digitalocean)
