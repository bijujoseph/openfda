#!/bin/bash

##
## Create an AWS EC2 instance from Amazon linux AMI and run the following commands in the comments
## You can run this on server using the following command:
## curl --silent --location https://raw.githubusercontent.com/bijujoseph/openfda/feature/FDA-13/quickstart.sh | bash -
##


# --------------------------------
# Step 0 - Setup environment
# --------------------------------

sudo mkdir -p /work/outputs/ && sudo chmod -R 777 /work
sudo mkdir /data0 && sudo chmod 777 /data0/

cd /work
cat<<EOF > /work/apiserver.sh
#!/bin/bash
cd /work/openfda/api/faers
npm run start
EOF
chmod 777 apiserver.sh

#---------------------------------
# Step 1 - Install Node.js & NPM
# --------------------------------

sudo curl --silent --location https://rpm.nodesource.com/setup | bash -
sudo yum install -y git nodejs npm gcc
sudo mkdir -p /work && sudo chmod 777 /work && mkdir -p /work/output/
cd /work
git clone https://github.com/bijujoseph/openfda.git
cd /work/openfda
git checkout -b feature/FDA-13 --track origin/feature/FDA-13
chmod 777 *.sh

#---------------------------------
# Step 2 - Install ElasticSearch
# --------------------------------

cd /tmp && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.7.1.tar.gz && \
  tar xvzf elasticsearch-1.7.1.tar.gz && \
  rm -f elasticsearch-1.7.1.tar.gz && \
  sudo mkdir /elasticsearch && \
  sudo chmod 777 /elasticsearch && \
  cp -R /tmp/elasticsearch-1.7.1/* /elasticsearch/

chmod 777 /elasticsearch/bin/* && \

cp /work/openfda/deploy/docker/elasticsearch-dev/*.yml /elasticsearch/config/
cd /work/openfda/


#------------------------------------------------
#Step 3 - Compile backoffice python & API website
#------------------------------------------------

./bootstrap.sh

# Step 4 - Start in background EasticSearch Server
echo 'Starting ElasticSearch server, you can check the output in /work/outputs/apiserver.out'
cd /elasticsearch/bin
nohup ./elasticsearch > /work/outputs/elasticsearch.out &

#---------------------------------
# Step 5 - Start API server
#---------------------------------
sleep 20
echo 'Starting API server, you can check the output in /work/outputs/apiserver.out'

cd /work
nohup ./apiserver.sh > /work/outputs/apiserver.out &


# --------------------------------
# Step 6 - Run all pipelines
# --------------------------------
echo 'To run pipelines run the following command : '
echo './scripts/all-pipelines.sh'
