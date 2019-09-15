#!/bin/bash
#
# 2019.09.15 v1.0 (the base one)
# by wilmos

## env config
sudo su - root -c "/bin/echo  '/usr/bin/echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables' >> /etc/rc.local"
sudo iptables -t nat -A PREROUTING -d 10.1.0.165 -j DNAT --to-destination 10.0.2.15
sudo su - root -c "/bin/echo '/sbin/iptables -t nat -A PREROUTING -d 10.1.0.165 -j DNAT --to-destination 10.0.2.15' >> /etc/rc.local"
sudo /sbin/setenforce 0
sudo su - root -c "/bin/sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config"


## install base package 
sudo yum install -y zip unzip git net-tools vim curl wget

## install docker
sudo yum -y remove docker \
             docker-client \
             docker-client-latest \
             docker-common \
             docker-latest \
             docker-latest-logrotate \
             docker-logrotate \
             docker-engine
sudo yum install -y yum-utils \
         device-mapper-persistent-data \
    lvm2
# install docker from network
#sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
cd /tmp/package
sudo cp  docker-ce.repo /etc/yum.repos.d/  
sudo yum-config-manager --enable docker-ce-nightly
sudo yum-config-manager --enable docker-ce-test
#sudo yum install -y docker-ce \
#       docker-ce-cli \
#       containerd.io
# install docker from localhost
sudo yum install -y docker-ce-19.03.1-3.el7.x86_64.rpm \
       docker-ce-cli-19.03.1-3.el7.x86_64.rpm \
       containerd.io-1.2.6-3.3.el7.x86_64.rpm
sudo systemctl enable docker
sudo systemctl start docker
sudo systemctl status docker
sudo docker run hello-world
sudo su - root -c  "curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://f1361db2.m.daocloud.io"
sudo systemctl stop docker
sudo systemctl start docker
sudo systemctl status docker


## install minikube and kubectl 
sudo cp kubectl /usr/local/bin/kubectl
sudo chmod +x /usr/local/bin/kubectl
#wget https://dl.k8s.io/v1.9.3/kubernetes-client-linux-amd64.tar.gz
#tar -zxvf kubernetes-client-linux-amd64.tar.gz
#cd kubernetes/client/bin
#chmod +x ./kubectl
#sudo mv ./kubectl /usr/local/bin/kubectl
#sudo cp minikube /usr/local/bin/minikube
#sudo chmod +x /usr/local/bin/minikube
sudo curl -Lo minikube http://kubernetes.oss-cn-hangzhou.aliyuncs.com/minikube/releases/v1.2.0/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/


## lunch k8s cluster
sudo su - root -c "swapoff -a"
sudo su - root -c "/usr/bin/echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables"
sudo su - root -c "minikube start --registry-mirror=https://registry.docker-cn.com --vm-driver=none"
#sudo su - root -c "minikube addons enable heapster"

## pull basic image
#sudo su - root -c "docker pull daocloud.io/library/node:6.14.2"
#sudo su - root -c "docker pull daocloud.io/library/nginx"
#sudo su - root -c "docker pull gogs/gogs"

## init app env

## init git env
echo "env init finished!"
