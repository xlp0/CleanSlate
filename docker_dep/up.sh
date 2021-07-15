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
    LOCALSETTINGS_FILENAME="LocalSettings.php"
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

echo "Please go to a browser and use http://$HOST_STRING:$PORT_NUMBER to test the service"

docker-compose up -d 
