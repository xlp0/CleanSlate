#! /bin/bash
#
#
#
#
## Get current date ##
## $(date +"%m_%d_%Y")
_now=$(date +"%m_%d_%Y_%H%M")

## Appending a current date from a $_now to a filename stored in $_file ##
_file="~/mount/backup/mariadb/cleanslate_bak_$_now.sql.gz"
_filename="cleanslate_bak_$_now.sql.gz"
#
#
echo "---------------------------------------------------"
echo "This script will create database backup on folder  "
echo "$_file"
echo "~/mount/backup/images/mediafile_$_now.zip"
echo "---------------------------------------------------"
read -p "Press any key to continue or ctrl-C to cancel"
echo ""
echo ""
#
echo "Creating database backup files on $_file"
POD=$(kubectl get pod -l app=cleanslate-db -o jsonpath="{.items[0].metadata.name}")
echo 'Executing command on POD:' $POD
#
kubectl exec -i $POD -- /bin/bash -c "mysqldump -h 127.0.0.1 -u root -proot --all-databases --skip-lock-table | gzip -c > /mnt/backup/$_filename"
#
# create temporary folder
PODAPP=$(kubectl get pod -l app=cleanslate-app -o jsonpath="{.items[0].metadata.name}")
# echo 'Executing command on POD:' $PODAPP
# echo "mkdir /var/www/html/images_backup/$_now"
kubectl exec -i $PODAPP -- /bin/bash -c "mkdir /var/www/html/images_backup/$_now"

## push backup file here
kubectl exec -i $PODAPP -- /bin/bash -c "php /var/www/html/maintenance/dumpUploads.php | sed 's~mwstore://local-backend/local-public~./images~' | xargs cp -t /var/www/html/images_backup/$_now"

# zip everything
kubectl exec -i $PODAPP -- /bin/bash -c "zip -r /var/www/html/images_backup/mediafile_$_now.zip /var/www/html/images_backup/$_now"

# delete remaining footprint
kubectl exec -i $PODAPP -- /bin/bash -c "rm -rf /var/www/html/images_backup/$_now"

# notify
echo "Mediafile backup on mount/backup/images/mediafile_$_now.zip is complete"
echo "Database backup on mount/backup/mariadb/cleanslate_bak_$_now.sql.gz is complete"

