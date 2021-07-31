kubectl apply -f sc-bak-db.yml
kubectl apply -f sc-bak-img.yml
kubectl apply -f sc-db.yml
kubectl apply -f sc-image.yml
kubectl apply -f sc-restore-db.yml   
kubectl apply -f sc-restore-img.yml
#
kubectl apply -f dep.yml