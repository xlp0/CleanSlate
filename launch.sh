#!/bin/sh
echo Launching XLP system based on Kubernetes with master node only...
echo ====================
kubeadm init --pod-network-cidr=10.244.0.0/16
export KUBECONFIG=/etc/kubernetes/admin.conf
sleep 10s
echo ====================
echo Applying flannel and enabling network...
kubectl apply -f kube-flannel.yml
sleep 10s
echo ====================
echo Set taint nodes...
kubectl taint nodes --all node-role.kubernetes.io/master-
sleep 5s
echo ====================
echo Launching XLP system...
kubectl apply -f xlpsystem-full.yaml
sleep 20s
echo ====================
echo XLP system has now been launcher, please check the status of the pods using `kubectl get pods --all-namespaces`
echo and wait for all pods until their status are all `running`
kubectl get pods --all-namespaces

