#!/bin/bash

# Update the package index
sudo apt update


# Install Java (OpenJDK 11 is recommended for Jenkins)
sudo apt install -y openjdk-11-jdk



# Add the Jenkins repository key
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null




# Update the package index again to include Jenkins repository
sudo apt update

# Install Jenkins (latest version)
sudo apt install -y jenkins

# Start Jenkins service
sudo systemctl start jenkins

# Enable Jenkins to start on boot
sudo systemctl enable jenkins

# Display Jenkins initial admin password
echo "Wait for Jenkins to start..."
sleep 30 # wait for Jenkins to start
echo "Jenkins initial admin password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
