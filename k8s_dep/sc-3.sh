#! /bin/bash
#
#
kubectl apply -f ./yml-3/sc-bak-db.yml
kubectl apply -f ./yml-3/sc-bak-img.yml
kubectl apply -f ./yml-3/sc-db.yml
kubectl apply -f ./yml-3/sc-image.yml
kubectl apply -f ./yml-3/sc-restore-db.yml   
kubectl apply -f ./yml-3/sc-restore-img.yml
#
kubectl apply -f ./yml-3/dep.yml