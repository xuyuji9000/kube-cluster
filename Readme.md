Create a Kubernetes cluster on Digital Ocean with ansible.

# Ansible

- `export ANSIBLE_HOST_KEY_CHECKING=False`

- `ansible all -m ping -i hosts`

# Terraform

- `export DIGITALOCEAN_TOKEN=digitalocean_token`

- `cat ~/.config/doctl/config.yaml | grep token`


# Reference

1. [How To Create a Kubernetes 1.11 Cluster Using Kubeadm on Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-create-a-kubernetes-1-11-cluster-using-kubeadm-on-ubuntu-18-04)

2. [Install kubeadm](https://kubernetes.io/docs/setup/independent/install-kubeadm/)
