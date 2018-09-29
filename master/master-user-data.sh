#!/bin/sh



DOCKER_VERSION=17.03
KUBE_VERSION=1.11.3-00
KUBECTL_HOME=/root

cd $KUBECTL_HOME

exec &> logfile.txt

# install Docker
apt-get update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
apt-get update && apt-get install -y docker-ce=$(apt-cache madison docker-ce | grep ${DOCKER_VERSION} | head -1 | awk '{print $3}')


# Install Kubernentes dependency
apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet=${KUBE_VERSION} kubeadm=${KUBE_VERSION} kubectl=${KUBE_VERSION}
apt-mark hold kubelet kubeadm kubectl

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
