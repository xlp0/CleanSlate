#! /bin/bash

# Check .env file exists before process
if [ -f .env ]; then
    # Calls env files to read environment variables
    . .env
   echo "File .env exists, below are the parameters stored"
   echo "-------------------------------------------------"
   echo "Local Persistence volume will be mounted from: $LOCAL_FOLDER"
   echo "Space allocated for cluster is: $LOCAL_STORAGE_SPACE"
   echo "External IP Address is: $EXTERNAL_IP_ADDRESS"
   echo "External port number is: $EXPOSED_PORT_NUMBER"
   echo "-------------------------------------------------"
   echo ""
   read -p "Please review the parameter and Press any key to continue or ctrl-C to cancel"
   echo ""
   echo ""
else
   echo "File .env does not exist, exiting installation"
   exit 0
fi

# Must mount from local host to kube
echo "Mounting to: $LOCAL_FOLDER:/home/docker/mount"
minikube start --mount --mount-string="$LOCAL_FOLDER:/home/docker/mount"

# create execute yaml file, overwrite if exist
cp clean_slate.yml clean_slate_exec.yml

# Apply .env parameters into yaml file
# amount of local storage
sed -i -e 's, LOCAL_STORAGE_SPACE, '$LOCAL_STORAGE_SPACE',g' clean_slate_exec.yml
# External exposed IP address
sed -i -e 's, EXTERNAL_IP_ADDRESS, '$EXTERNAL_IP_ADDRESS',g' clean_slate_exec.yml
# External exposed port number
sed -i -e 's, EXPOSED_PORT_NUMBER, '$EXPOSED_PORT_NUMBER',g' clean_slate_exec.yml

# create execute yaml file, overwrite if exist
cp $LOCAL_FOLDER/LocalSettings-template.php $LOCAL_FOLDER/LocalSettings.php
sed -e 's, SERVER_URL, "'http://$EXTERNAL_IP_ADDRESS:$EXPOSED_PORT_NUMBER'",g' $LOCAL_FOLDER/LocalSettings.php > $LOCAL_FOLDER/tmp.php && mv $LOCAL_FOLDER/tmp.php $LOCAL_FOLDER/LocalSettings.php

# apply config files
kubectl apply -f clean_slate_exec.yml