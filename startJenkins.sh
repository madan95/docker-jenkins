#!/usr/bin/env bash

if [ ! -d "jenkins_home" ]; then
  # Control will enter here if jenkins_home does not exists.
  # jenkins_home holds presitent data form jenkins container for future use
  mkdir jenkins_home
fi

docker-compose up -d --build

docker exec -it -u root jenkins_container bash -c 'apt-get update && \
apt-get -y install apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common && \
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable" && \
apt-get update && \
apt-get -y install docker-ce'

#Create Keys insdie container if it doesn't exist
docker exec -it jenkins_container bash -c 'ls -la && \
yes "" | ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa'


#Save the container key to current server authorized key for future pipline work
docker exec -it jenkins_container bash  -c 'cat ~/.ssh/id_rsa.pub' >> ~/.ssh/authorized_keys

#Check if container was started
docker ps

#Get intial password needed for jenkins
docker exec jenkins_container cat /var/jenkins_home/secrets/initialAdminPassword
