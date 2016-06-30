#!/bin/bash

## Create an AWS EC2 instance from Amazon linux AMI and run the following commands in the comments

## sudo mkdir /work && sudo chmod 777 /work
## cd /work
## sudo yum install -y git
## git clone https://github.com/bijujoseph/openfda.git
## cd openfda
## git checkout -b feature/FDA-13 --track origin/feature/FDA-13
## chmod 777 *.sh
## ./quickstart.sh
##


# Step 1 - Install Node.js & NPM

sudo curl --silent --location https://rpm.nodesource.com/setup | bash -
sudo yum install -y nodejs npm gcc


# Step 2 - Install ElasticSearch

cd /tmp && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.7.1.tar.gz && \
  tar xvzf elasticsearch-1.7.1.tar.gz && \
  rm -f elasticsearch-1.7.1.tar.gz && \
  sudo mkdir /elasticsearch && \
  sudo chmod 777 /elasticsearch && \
  cp -R /tmp/elasticsearch-1.7.1/* /elasticsearch/

chmod 777 /elasticsearch/bin/* && \

sudo mkdir /data0 && sudo chmod 777 /data0/
cp /work/openfda/deploy/docker/elasticsearch-dev/*.yml /elasticsearch/config/
cd /work/openfda/


#Step 3 - Compile backoffice python & API website
./bootstrap.sh

# Step 4 - Start in background API Server

# Step 5 - Start in background EasticSearch Server

# Step 6 - Run all pipelines


