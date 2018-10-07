#!/bin/sh

KUBECTL_HOME=/root

cd $KUBECTL_HOME

# Init kubeadm
kubeadm init --pod-network-cidr=10.244.0.0/16


# Setup kubectl

mkdir -p $KUBECTL_HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $KUBECTL_HOME/.kube/config
echo "----------Start of kubectl config----------"
cat $KUBECTL_HOME/.kube/config
echo "----------End of kubectl config----------"
sudo chown $(id -u):$(id -g) $KUBECTL_HOME/.kube/config

# Setup network
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/v0.10.0/Documentation/kube-flannel.yml
