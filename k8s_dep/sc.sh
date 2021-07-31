#! /bin/bash
#
#
kubectl apply -f ./yml/sc-bak-db.yml
kubectl apply -f ./yml/sc-bak-img.yml
kubectl apply -f ./yml/sc-db.yml
kubectl apply -f ./yml/sc-image.yml
kubectl apply -f ./yml/sc-restore-db.yml   
kubectl apply -f ./yml/sc-restore-img.yml
#
kubectl apply -f ./yml/dep.yml