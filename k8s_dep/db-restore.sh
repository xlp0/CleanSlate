#! /bin/bash
#
#
#
#
echo 'Restoring database from file on /mount/restore/mariadb/'
echo 'cleanslate-backup.sql'
POD=$(kubectl get pod -l app=cleanslate-db -o jsonpath="{.items[0].metadata.name}")
echo 'Executing command on POD:' $POD
#
kubectl exec -i $POD -- /bin/bash -c "mysql -u root -h 10.97.75.132 -proot < /mnt/restore/cleanslate-backup.sql"