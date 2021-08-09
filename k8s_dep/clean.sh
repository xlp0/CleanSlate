kubectl delete deployment cleanslate-app
kubectl delete deployment cleanslate-db
#
#
kubectl delete pvc db-pv-claim
kubectl delete pvc images-pv-claim
kubectl delete pvc backup-db-pv-claim
kubectl delete pvc backup-img-pv-claim
kubectl delete pvc restore-db-pv-claim
kubectl delete pvc restore-img-pv-claim
#
#
kubectl delete service cleanslate-db-srv
kubectl delete service cleanslate-srv
#
#
kubectl delete pv local-db-pv
kubectl delete pv images-pv
kubectl delete pv backup-db-pv
kubectl delete pv backup-img-pv
kubectl delete pv restore-db-pv
kubectl delete pv restore-img-pv
#
#
kubectl delete sc db-storage
kubectl delete sc sc-bak-db
kubectl delete sc sc-bak-img
kubectl delete sc sc-images
kubectl delete sc sc-restore-db
kubectl delete sc sc-restore-img