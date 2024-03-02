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
sudo apt-get update -q
sudo apt-get install -y docker.io kubeadm kubelet kubectl


# Enable and start Docker service
sudo systemctl enable docker
sudo systemctl start docker

# Become a Root User
sudo su 

# Join the worker node to the Kubernetes cluster
echo "Paste the 'kubeadm join' command obtained from the master node setup script here:"
read join_command
eval $join_command

echo "Kubernetes worker node setup completed."
