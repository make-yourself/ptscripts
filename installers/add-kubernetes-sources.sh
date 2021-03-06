#!/bin/bash
sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ aiy-debian-sid main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
# sudo apt-get install -y kubectl
# else: via snapd > sudo /etc/init.d/snapd start && snap install kubectl --classic