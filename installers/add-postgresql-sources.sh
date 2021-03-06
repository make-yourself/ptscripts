#!/bin/bash


sudo apt-get install curl ca-certificates gnupg
sudo rm -rf /var/apt/cache/archives
apt autoclean && apt-autoremove
curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
if [[ ! -d "/etc/apt/sources.list.d/" ]]; then mkdir /etc/apt/sources.list.d/ ; fi
echo 'deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main' > /etc/apt/sources.list.d/pgdg.list
sudo apt-get update