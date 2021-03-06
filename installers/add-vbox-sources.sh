#!/bin/bash


sudo apt-get install curl ca-certificates gnupg
sudo rm -rf /var/apt/cache/archives
sudo apt autoclean && sudo apt autoremove
curl 'https://www.virtualbox.org/download/oracle_vbox_2016.asc' | sudo apt-key add
#	key fingerprint:
#	B9F8 D658 297A F3EF C18D  5CDF A2F6 83C5 2980 AECF
if [[ ! -d "/etc/apt/sources.list.d/" ]]; then mkdir /etc/apt/sources.list.d/ ; fi
echo 'deb https://download.virtualbox.org/virtualbox/debian jessie contrib' >/etc/apt/sources.list.d/vbox.list
sudo apt-get update
