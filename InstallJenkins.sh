#!/usr/bin/env bash
# Install Jenkins on Ubuntu 20.04
echo "This script was only written for Ubuntu 20.04 to install Jenkins"
echo "For more detail, see https://xlp.pub/index.php/Jenkins"

echo "You need to have administrator access to run this script, type:sudo InstallJeninks.sh"

echo "Install java"
apt install openjdk-11-jre-headless -y

# Add repository key for Jenkins
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -

# Append the debian repistory package 
sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

# Update software through apt update
apt update

# Install Jenkins and its dependencies
apt install jenkins -y

# Use systemctl to start Jenkins service
sudo systemctl start jenkins

echo "Wait for 5 seconds before checking jenkins's service status"
sleep 5
# Check Jenkin's status
systemctl status jeninks

# Following the following steps on https://xlp.pub/index.php/Jenkins to finish installation.
echo "Following the following steps (step 7 and later) on https://xlp.pub/index.php/Jenkins to finish installation of Jenkins"
echo "Before using a browser to access Jenkins, make sure that you first open up port 8080 on that machine."
