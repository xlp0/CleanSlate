#! /bin/bash
#
#
kubectl apply -f ./yml-1/sc-bak-db.yml
kubectl apply -f ./yml-1/sc-bak-img.yml
kubectl apply -f ./yml-1/sc-db.yml
kubectl apply -f ./yml-1/sc-image.yml
kubectl apply -f ./yml-1/sc-restore-db.yml   
kubectl apply -f ./yml-1/sc-restore-img.yml
#
kubectl apply -f ./yml-1/dep.yml