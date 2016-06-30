#!/bin/bash

## Create an AWS EC2 instance from Amazon linux AMI (as it has Docker)
## mkdir /work
## cd /work
## yum install git
## git clone https://github.com/bijujoseph/openfda.git
## cd openfda
## git checkout -b feature/FDA-13 --track origin/feature/FDA-13
## chmod 777 *.sh
## ./quickstart.sh
##
sudo yum install -y nodejs npm gcc
cd /tmp && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.7.1.tar.gz && \
  tar xvzf elasticsearch-1.7.1.tar.gz && \
  rm -f elasticsearch-1.7.1.tar.gz && \
  sudo mkdir /elasticsearch && \
  sudo chmod 777 /elasticsearch && \
  cp -R /tmp/elasticsearch-1.7.1/* /elasticsearch/

chmod 777 /elasticsearch/bin/* && \

sudo mkdir /data0 && sudo chmod 777 /data0/
cp /work/openfda/deploy/elasticsearch-dev/*.yml /elasticsearch/config/
cd /work/openfda/
./bootstrap.sh


