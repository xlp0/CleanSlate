#! /bin/bash
# this scrip will update semantic media wiki
#
#
# pod for application
echo 'Getting POD for application'
PODAPP=$(kubectl get pod -l app=cleanslate-app -o jsonpath="{.items[0].metadata.name}")

# run update
echo 'Run on $PODAPP'
kubectl exec -i $PODAPP -- /bin/bash -c "php /var/www/html/maintenance/update.php --quick --force"
# kubectl exec -i $PODAPP -- /bin/bash -c "php /var/www/html/maintenance/setupStore.php --quick --force"