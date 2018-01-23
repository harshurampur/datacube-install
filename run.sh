#!/bin/bash

DC_TAG=datacube-1.5.4

# Upgrade and install dependencies
# Postgres is installed and configured in order to run integration tests
sudo apt-get update 
sudo apt-get upgrade -y 
sudo apt-get install -y wget bzip2 git postgresql gcc g++ ca-certificates 
sudo apt-get clean
locale-gen en_US.UTF-8 en_US

# Run datacube script
./datacube_setup.sh $DC_TAG
~
~
~

