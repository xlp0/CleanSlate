#! /bin/bash
#
# $1 -> data base file on /mount/backup/mariadb folder
# $2 -> images file on /mount/backup/images folder
#
echo "---------------------------------------------------"
echo "This script will restore:"
echo "database file : /mount/restore/mariadb/$1"
echo "images file   : /mount/restore/images/$2"
echo ""
echo "Caution, existing content will be replaced"
echo "---------------------------------------------------"
read -p "Press any key to continue or ctrl-C to cancel"
echo ""
echo ""

echo "Restoring database from file on /mount/restore/mariadb/$1"
# pod for database
POD=$(kubectl get pod -l app=cleanslate-db -o jsonpath="{.items[0].metadata.name}")
# pod for application
PODAPP=$(kubectl get pod -l app=cleanslate-app -o jsonpath="{.items[0].metadata.name}")

echo 'Executing command on POD:' $POD
# starting images restore process
# create new folder
IMG_FOLDER=$(echo "$2" | cut -f 1 -d '.')
#echo "mkdir /var/www/html/images_restore/$IMG_FOLDER"
kubectl exec -i $PODAPP -- /bin/bash -c "mkdir /var/www/html/images_restore/$IMG_FOLDER"

# gunzip the images
echo "unzip /var/www/html/images_restore/$2 -d /var/www/html/images_restore/$IMG_FOLDER"
kubectl exec -i $PODAPP -- /bin/bash -c "unzip -j /var/www/html/images_restore/$2 -d /var/www/html/images_restore/$IMG_FOLDER"
                                         
# run maintenance/importImages.php
echo "php /var/www/html/maintenance/importImages.php /var/www/html/images_restore/$IMG_FOLDER"
kubectl exec -i $PODAPP -- /bin/bash -c "php /var/www/html/maintenance/importImages.php /var/www/html/images_restore/$IMG_FOLDER"

# run update
kubectl exec -i $PODAPP -- /bin/bash -c "php /var/www/html/maintenance/update.php --quick"

# delete footprint
# echo "rm -rf /var/www/html/images_restore/$IMG_FOLDER"
kubectl exec -i $PODAPP -- /bin/bash -c "rm -rf /var/www/html/images_restore/$IMG_FOLDER"

# Database Restore
echo "Starting Database Restore ..."
DB_FILE=$(echo "$1" | cut -f 1 -d '.')
kubectl exec -i $POD -- /bin/bash -c "gunzip < /mnt/restore/$1 | mysql -u root -h 10.97.75.132 -proot"
#
echo "---------------------------------------------------"
echo "Database and images restore completed"
echo ""
echo "---------------------------------------------------"
