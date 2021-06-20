#! /bin/bash

add-apt-repository universe

apt-get update -y

apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    zip \
    unzip \
    cron \
    dos2unix

dos2unix *.sh

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -y 

apt-get install docker-ce docker-ce-cli containerd.io docker.io docker-compose -y 

apt install docker.io

systemctl daemon-reload
systemctl restart docker


apt-get install -y apt-transport-https
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add -
cp ./kubernetes.list /etc/apt/sources.list.d/
apt-get update
apt-get install -y kubelet=1.15.0-00 kubeadm=1.15.0-00 kubectl=1.15.0-00

#rm /etc/resolv.conf
#cp ./resolv.conf /etc/

image=(
    kube-apiserver:v1.15.0
    kube-controller-manager:v1.15.0
    kube-scheduler:v1.15.0
    kube-proxy:v1.15.0
    pause:3.1
    etcd:3.3.10
    coredns:1.3.1
)

for imageName in ${image[@]} ; do
    docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName
    docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/$imageName k8s.gcr.io/$imageName
done

