#! /bin/bash

# 
$LOCAL_FOLDER="/Users/muhammadhaviz/Anindhaloka Drive/2021.07.Personal Knowledge Container/CleanSlate/kubernetes_deployment/mountPoint"

# Must mount from local host to minikube
# minikube start --mount --mount-string="/Users/muhammadhaviz:/home/docker/mount"

# apply database
# kubectl apply -f clean_slate_deployment.yml

# apply apps
# kubectl apply -f maria-db-deployment.yml

# start exposing service to external ip
# minikube service cleanslate-srv