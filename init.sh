#!/bin/bash
# Setup the repository for Docker
sudo apt-get --assume-yes update
sudo apt-get --assume-yes install ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install the Docker engine
sudo apt-get --assume-yes update
sudo apt-get --assume-yes install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Clone the simple taiko node repo and setup .env file
git clone https://github.com/taikoxyz/simple-taiko-node.git
cd simple-taiko-node
cp .env.sample .env
sudo chown -R ubuntu .

# Pull the latest taiko node image
sudo docker compose pull

exit 0