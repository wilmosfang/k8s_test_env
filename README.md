---
layout: post
title: "K8s test env"
date: 2019-09-15 15:06:15
image: '/assets/img/'
description:  '自动构建 k8s 测试环境 xxx as Code'
main-class:  'tools'
color: 
tags: 
 - tools
 - script
 - k8s
categories:
 - tools
twitter_text:  "auto build k8s env"
introduction: "auto build k8s env"
---

## 基础软件依赖

需要系统中已经安装如下两个软件

* **virtualbox 6.0.10**
* **vagrant 2.2.5**


## 安装方法

~~~
git clone https://github.com/wilmosfang/k8s_test_env.git
cd k8s_test_env
vagrant up
~~~

## 备注

如果网络质量好(能科学上网)，可以通过注释掉以下几行，将此环境完全代码化

### Vagrantfile


comment this line 

~~~
config.vm.provision "file", source: "./package", destination: "/tmp/package"
~~~

### init.bash

uncomment this line

~~~
#sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
#sudo yum install -y docker-ce \
#       docker-ce-cli \
#       containerd.io
#wget https://dl.k8s.io/v1.9.3/kubernetes-client-linux-amd64.tar.gz
#tar -zxvf kubernetes-client-linux-amd64.tar.gz
#cd kubernetes/client/bin
#chmod +x ./kubectl
#sudo mv ./kubectl /usr/local/bin/kubectl
~~~

comment these line

~~~
cd /tmp/package
sudo cp  docker-ce.repo /etc/yum.repos.d/  
sudo yum install -y docker-ce-19.03.1-3.el7.x86_64.rpm \
       docker-ce-cli-19.03.1-3.el7.x86_64.rpm \
       containerd.io-1.2.6-3.3.el7.x86_64.rpm
sudo cp kubectl /usr/local/bin/kubectl
sudo chmod +x /usr/local/bin/kubectl
~~~

这样就不需要package 中的内容, 减少130M的数据传输量
