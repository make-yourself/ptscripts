#!/bin/bash
sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2
echo "deb https://download.docker.com/linux/debian/ wheezy" | sudo tee -a /etc/apt/sources.list.d/docker.list
sudo apt-get update
# sudo apt-get install -y docker-compose docker-ce
