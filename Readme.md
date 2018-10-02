Create a Kubernetes cluster on Digital Ocean with ansible and terraform.

# Cluster

## Setup

1. `./utility/infra.sh apply` creates one master and one worker with firewalls.

2. `./utility/add-kubectl-control.sh master-ip` add remote cluster **/root/.kube/config** to local *kubectl*

3. Create `hosts` file according to `hosts.example`, update master and worker public ip

4. `./utility/infra.sh join` lets workers join the cluster

## Destroy

1. `./utility/infra.sh destroy` destroies the provisioned resources.


## Test

- SSH into master node, run `kubectl get nodes`, should have result like this:

    ![image](https://user-images.githubusercontent.com/4877346/45913656-2700af80-be69-11e8-854a-8882bff1de92.png)

- `./utility/infra.sh test` test servers under inventory

# Jenkins


# Reference

1. [How To Create a Kubernetes 1.11 Cluster Using Kubeadm on Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-create-a-kubernetes-1-11-cluster-using-kubeadm-on-ubuntu-18-04)

2. [Install kubeadm](https://kubernetes.io/docs/setup/independent/install-kubeadm/)

3. [Creating a single master cluster with kubeadm](https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/)

4. [csi-digitalocean](https://github.com/digitalocean/csi-digitalocean)
