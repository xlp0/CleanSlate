kubectl delete deployment cleanslate-app
kubectl delete deployment cleanslate-db
kubectl delete service cleanslate-db-srv
kubectl delete service cleanslate-srv
kubectl delete pvc db-pv-claim
kubectl delete pvc media-pv-claim
kubectl delete pv media-pv
kubectl delete pv local-db-pv