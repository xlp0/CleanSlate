#! /bin/bash
#
#
kubectl apply -f ./yml-2/sc-bak-db.yml
kubectl apply -f ./yml-2/sc-bak-img.yml
kubectl apply -f ./yml-2/sc-db.yml
kubectl apply -f ./yml-2/sc-image.yml
kubectl apply -f ./yml-2/sc-restore-db.yml   
kubectl apply -f ./yml-2/sc-restore-img.yml
#
kubectl apply -f ./yml-2/dep.yml