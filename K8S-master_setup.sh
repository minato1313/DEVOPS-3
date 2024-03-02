#!/bin/bash

# Check if the script is run by a sudo user
if [[ $EUID -eq 0 ]]; then
    echo "This script should not be run as root. Please run it as a regular user with sudo privileges."
    exit 1
fi


# Update and install necessary packages
sudo apt-get update -q
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common


# Add the Kubernetes GPG key
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -


# Add the Kubernetes repository
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list


# Install Docker and Kubernetes components
sudo swapoff -a
sudo apt-get update -q
sudo apt-get install -y docker.io kubeadm kubelet kubectl



# Enable and start Docker service
sudo systemctl enable docker
sudo systemctl start docker

# Initialize the Kubernetes master node with kubeadm
sudo kubeadm init 

# Set up kubeconfig for the regular user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Deploy a network plugin (e.g., Calico)
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
#kubectl apply -f https://docs.projectcalico.org/v3.21/manifests/calico.yaml

# Print instructions for joining worker nodes to the cluster
echo "Kubernetes master node is initialized. Run the following command on worker nodes to join the cluster:"
sudo kubeadm token create --print-join-command

# Optional: Install kubectl completion
echo 'source <(kubectl completion bash)' >> $HOME/.bashrc

echo "Kubernetes master node setup completed."

