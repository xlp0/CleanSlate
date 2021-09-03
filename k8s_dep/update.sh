#! /bin/bash
#
# pod for application
PODAPP=$(kubectl get pod -l app=cleanslate-app -o jsonpath="{.items[0].metadata.name}")
# run update
kubectl exec -i $PODAPP -- /bin/bash -c "php /var/www/html/maintenance/update.php --quick"