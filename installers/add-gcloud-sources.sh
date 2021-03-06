#!/bin/bash


# install apt https and insure ca-certificates valid+current
apt-get install apt-transport-https ca-certificates
# add google deb/apt sources
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
## alt curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
# make sources.list.d dir if dne, add gcloud entry
if [[ ! -d "/etc/apt/sources.list.d/" ]]; then mkdir /etc/apt/sources.list.d/ ; fi
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
# cli tools
sudo apt-get install google-cloud-sdk google-cloud-sdk-datalab google-cloud-sdk-pubsub-emulator google-cloud-sdk-cbt google-cloud-sdk-cloud-build-local google-cloud-sdk-bigtable-emulator
# install and update gcloud compenents past apt repository version
gcloud compontents install docker-credential-gcr
gcloud components update
# kubernetes app engine extension
sudo apt-get install kubectl
# list installed components to verify
gcloud components list
# disregard, old: unless credentials manually stored to file glcoud will open in your browser and that's not going to work too well with firefox esr, copypasta link chromium or google-chrome-stable --nosandbox and follow, this should also save you the problem of starting burpsuite if you're in the middle of a test
# disregard, old: gcloud init
# there are better ways 1.)
glcoud auth login --no-launch-browser 
## you are now free to copy the provided link in any browser on any host or device you are already logged into and return to input the provided token in your cli
# 2.)
# gcloud auth activate-service-account
## Authorize with a service account instead of a user account, default non-interactive
# 3.)
# gcloud init --console-only
##
# gcloud sdks
sudo apt-get install google-cloud-sdk-app-engine-go google-cloud-sdk-app-engine-java google-cloud-sdk-app-engine-python google-cloud-sdk-app-engine-python-extras