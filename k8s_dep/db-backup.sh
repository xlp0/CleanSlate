#! /bin/bash
#
#
#
#
echo 'Creating backup files on /mount/backup/mariadb/'
POD=$(kubectl get pod -l app=cleanslate-db -o jsonpath="{.items[0].metadata.name}")
echo 'Executing command on POD:' $POD
#
kubectl exec -i $POD -- /bin/bash -c "mysqldump -h 127.0.0.1 -u root -proot --all-databases > /mnt/backup/cleanslate-backup.sql"