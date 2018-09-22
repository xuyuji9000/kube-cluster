Create a Kubernetes cluster on Digital Ocean with ansible and terraform.

# Setup

1. Under **master** directory, `terraform apply`, this step create master node with dependency.

2. Under **workder** directory, `terraform apply`, this step create worker node with dependency.

3. Create `hosts` file according to `hosts.example`, update master and worker public ip

4. Add cluster network, `ansible-playbook -i hosts master.yml`

4. Let worker join the cluster, `ansible-playbook -i hosts workers.yml`


# Test

SSH into master node, run `kubectl get nodes`, should have result like this: 

![image](https://user-images.githubusercontent.com/4877346/45913656-2700af80-be69-11e8-854a-8882bff1de92.png)



# Utilities

## Ansible

- `export ANSIBLE_HOST_KEY_CHECKING=False`

- `ansible all -m ping -i hosts`

## Terraform

- `export DIGITALOCEAN_TOKEN=digitalocean_token`

- `cat ~/.config/doctl/config.yaml | grep token`

- `export TF_VAR_do_token=digitalocean_token`

## DigitalOcean Cli

- `doctl compute droplet delete -f $(doctl compute droplet list --format Name --no-header)`


# Reference

1. [How To Create a Kubernetes 1.11 Cluster Using Kubeadm on Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-create-a-kubernetes-1-11-cluster-using-kubeadm-on-ubuntu-18-04)

2. [Install kubeadm](https://kubernetes.io/docs/setup/independent/install-kubeadm/)
