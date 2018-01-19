#!/bin/bash

DC_TAG=datacube-1.5.4

# Upgrade and install dependencies
# Postgres is installed and configured in order to run integration tests
sudo yum update 
sudo yum upgrade -y 
sudo yum install -y wget bzip2 git postgresql gcc g++ ca-certificates 
sudo yum clean
locale-gen en_US.UTF-8 en_US

# Run datacube script
./datacube_setup.sh $DC_TAG
~
~
~

