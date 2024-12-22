#!/bin/bash

# Script to Install Docker, Jenkins, and Ansible with Tests
set -e  # Exit immediately if a command exits with a non-zero status.

# ---------------------------
# Helper Functions
# ---------------------------
log() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $1"
}

install_packages() {
  log "Installing: $*"
  sudo apt-get install -y "$@"
}

add_user_to_group() {
  log "Adding user '$1' to group '$2'"
  sudo usermod -aG "$2" "$1"
}

add_repository() {
  local repo_url=$1
  local key_url=$2
  local keyring_path=$3
  local repo_entry=$4

  log "Adding repository from $repo_url"
  sudo mkdir -p "$(dirname "$keyring_path")"
  sudo curl -fsSL "$key_url" -o "$keyring_path"
  sudo chmod a+r "$keyring_path"
  echo "$repo_entry" | sudo tee /etc/apt/sources.list.d/$(basename "$repo_url").list > /dev/null
  sudo apt-get update
}

# ---------------------------
# Pre-Checks
# ---------------------------
if [ -z "$1" ]; then
  echo "Usage: $0 <username>"
  exit 1
fi

USERNAME="$1"

# ---------------------------
# Step 1: System Update
# ---------------------------
log "Updating system package list"
sudo apt-get update

# ---------------------------
# Step 2: Install Prerequisites
# ---------------------------
log "Installing prerequisites"
install_packages ca-certificates curl software-properties-common

# ---------------------------
# Step 3: Install Docker
# ---------------------------
log "Installing Docker"

DOCKER_KEY_URL="https://download.docker.com/linux/ubuntu/gpg"
DOCKER_KEYRING="/etc/apt/keyrings/docker.asc"
DOCKER_REPO="https://download.docker.com/linux/ubuntu"
DOCKER_REPO_ENTRY="deb [arch=$(dpkg --print-architecture) signed-by=$DOCKER_KEYRING] $DOCKER_REPO $(. /etc/os-release && echo "$VERSION_CODENAME") stable"

add_repository "$DOCKER_REPO" "$DOCKER_KEY_URL" "$DOCKER_KEYRING" "$DOCKER_REPO_ENTRY"
install_packages docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
add_user_to_group "$USERNAME" "docker"

sudo systemctl restart docker
log "Docker installed. Log out and back in for Docker group changes to take effect."

# ---------------------------
# Step 4: Install Jenkins
# ---------------------------
log "Installing Jenkins"

JENKINS_KEY_URL="https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key"
JENKINS_KEYRING="/usr/share/keyrings/jenkins-keyring.asc"
JENKINS_REPO="https://pkg.jenkins.io/debian-stable"
JENKINS_REPO_ENTRY="deb [signed-by=$JENKINS_KEYRING] $JENKINS_REPO binary/"

add_repository "$JENKINS_REPO" "$JENKINS_KEY_URL" "$JENKINS_KEYRING" "$JENKINS_REPO_ENTRY"
install_packages fontconfig openjdk-17-jre jenkins
add_user_to_group "jenkins" "docker"

sudo systemctl restart docker
sudo systemctl restart jenkins

if groups jenkins | grep -q docker; then
  log "Jenkins successfully added to Docker group."
else
  log "Failed to add Jenkins to Docker group."
fi

# ---------------------------
# Step 5: Install Ansible
# ---------------------------
log "Installing Ansible"
sudo add-apt-repository --yes --update ppa:ansible/ansible
install_packages ansible

# ---------------------------
# Step 6: Testing Installations
# ---------------------------
log "Testing installations"

log "Testing Docker"
if docker run hello-world > /dev/null 2>&1; then
  log "Docker is working correctly!"
else
  log "Docker test failed. Check the Docker installation."
fi

log "Testing Jenkins"
if systemctl is-active --quiet jenkins; then
  log "Jenkins is running!"
else
  log "Jenkins is not running. Check the Jenkins service."
fi

log "Testing Ansible"
if ansible --version > /dev/null 2>&1; then
  log "Ansible is installed correctly!"
else
  log "Ansible test failed. Check the Ansible installation."
fi

# ---------------------------
# Completion
# ---------------------------
log "Installation and testing completed successfully!"
