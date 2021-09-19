#! /bin/bash
# In case, there is no .env file
PORT_NUMBER="9352"

if [ -f .env ]; then
    export $(cat .env | grep -v '#' | awk '/=/ {print $1}')
    echo "Loaded environmental variable: PORT_NUMBER=$PORT_NUMBER"
fi

# In case, there is no .machine_specific_env file
TRANSPORT_STRING="http"
HOST_STRING="localhost"

if [[ ${TRANSPORT_STRING} =~  .*https.* ]]; then
    echo "To use the following transport string:  ${TRANSPORT_STRING}://$HOST_STRING"
    LOCATION_STRING="$HOST_STRING";
else
    echo "To use the following transport string:  ${TRANSPORT_STRING}://$HOST_STRING:$PORT_NUMBER"
    LOCATION_STRING="$HOST_STRING:$PORT_NUMBER";
fi

# Localhost configuration based on .env
    # Substitute to correct config if founded "$TargetKey =" in LocalSetting.php
    # Only replace 'var' instead of "var" 
    LOCALSETTINGS_FILENAME="./mountpoint/LocalSettings.php"
    # Put in all the params for configuration
    key_array=(
      "wgServer"
      )

    value_array=(
      $TRANSPORT_STRING://${LOCATION_STRING}
      )

    len=${#key_array[@]}
    for (( i=0; i<$len; i++ ));
    do
      echo "Replacing string in LocalSettings.php: ${key_array[$i]} "
      if [ ${key_array[$i]} = "wgLogos" ]; then
        sed "s|\$${key_array[$i]}[[:blank:]]*=.*|\$${key_array[$i]} = ${value_array[$i]};|" $LOCALSETTINGS_FILENAME > temp.txt && mv temp.txt $LOCALSETTINGS_FILENAME
      else  
        echo
        sed "s|\$${key_array[$i]}[[:blank:]]*=.*|\$${key_array[$i]} = \"${value_array[$i]}\";|" $LOCALSETTINGS_FILENAME > temp.txt && mv temp.txt $LOCALSETTINGS_FILENAME
      fi
    done

# read -p "Please review the parameter and Press any key to continue or ctrl-C to cancel"

echo 'Preparing mountPoint folder'
tar -xzvf mountpoint.tar.gz

docker-compose up -d
echo 'Waits until all container is active'
sleep 4  # Waits 5 seconds.
# run this command after everything
# php /var/www/html/maintenance/update.php --quick
# docker exec -d xlp_mediawiki php /var/www/html/maintenance/update.php --quick 
# docker exec -d xlp_mediawiki php /var/www/html/maintenance/rebuildrecentchanges.php
# docker exec -d xlp_mediawiki php /var/www/html/maintenance/initSiteStats.php
echo "Update database Media Wiki"
docker exec -d xlp_mediawiki php /var/www/html/maintenance/update.php --quick 
# ./update-sw.sh

echo "Please go to a browser and use http://$HOST_STRING:$MATOMO_PORT_NUMBER to access Matomo" 
echo "Please go to a browser and use http://$HOST_STRING:$PORT_NUMBER to test the WikiMedia"
echo "Please go to a browser and use http://$HOST_STRING:$GITEA_PORT_NUMBER to test the Gitea"
echo "Please go to a browser and use http://$HOST_STRING:$PHP_MA to test the PHPMyAdmin"