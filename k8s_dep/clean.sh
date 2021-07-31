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
kubectl delete pv local-db-pv
kubectl delete pv images-pv
kubectl delete pv backup-db-pv
kubectl delete pv backup-img-pv
kubectl delete pv restore-db-pv
kubectl delete pv restore-img-pv