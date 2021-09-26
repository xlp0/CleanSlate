#! /bin/bash
################################################################################
## Output command usage
function usage {
    local NAME=$(basename $0)
    echo "Usage: $NAME <file>"
    echo "       <file> Host file, listing of installation target server."
}

function prep_nginx {
    # sed -i 's/old-text/new-text/g' input.txt
    echo "Preparing NGINX Config Files ..."
    # 
    sed "s/#GIT_SUBDOMAIN/$GITEA_SUBDOMAIN/g" ./config-template/git.conf > ./config/git.conf
    sed "s/#PMA_SUBDOMAIN/$PMA_SUBDOMAIN/g" ./config-template/pma.conf > ./config/pma.conf
    sed "s/#MTM_SUBDOMAIN/$MTM_SUBDOMAIN/g" ./config-template/mtm.conf > ./config/mtm.conf
    sed "s/#YOUR_DOMAIN/$YOUR_DOMAIN/g" ./config-template/reverse-proxy.conf > ./config/reverse-proxy.conf
    sed "s/#YOUR_DOMAIN/$YOUR_DOMAIN/g" ./config-template/pkc.conf > ./config/pkc.conf
    echo ""
}

function prep_mw {
    echo "Prepare LocalSettings.php file"
    FQDN="$DEFAULT_TRANSPORT://www.$YOUR_DOMAIN"

    sed "s/#MTM_SUBDOMAIN/$MTM_SUBDOMAIN/g" ./config-template/LocalSettings.php > ./config/LocalSettings.php
    sed -i '' "s|#YOUR_FQDN|$FQDN|g" ./config/LocalSettings.php

}
################################################################################
## Main
# Preparation
# 

## Default, if no parameter is supplied
if [ -z "$1" ]; then
    echo "Hosts file is not specified, please see usage below"
    usage; exit 1;
fi

if [ -f .env ]; then
    export $(cat .env | grep -v '#' | awk '/=/ {print $1}')
    GITEA_SUBDOMAIN=git.$YOUR_DOMAIN
    PMA_SUBDOMAIN=pma.$YOUR_DOMAIN
    MTM_SUBDOMAIN=mtm.$YOUR_DOMAIN

    # Displays installation plan
    echo "--------------------------------------------------------"
    echo "Installation Plan:"
    echo "Ansible script to install on host file: $1"
    echo ""
    echo "Loaded environmental variable: "
    echo "Port number for Mediawiki: $PORT_NUMBER"
    echo "Port number for Matomo Service: $MATOMO_PORT_NUMBER"
    echo "Port number for PHPMyAdmin: $PHP_MA"
    echo "Port number for Gitea Service: $GITEA_PORT_NUMBER"
    echo ""
    echo "Your domain name is: $YOUR_DOMAIN"
    echo "default installation will configure below subdomain: "
    echo "PHPMyAdmin will be accessible from: $PMA_SUBDOMAIN"
    echo "Gitea will be accessible from: $GITEA_SUBDOMAIN"
    echo "Matomo will be accessible from: $MTM_SUBDOMAIN"
    echo "--------------------------------------------------------"
else
    echo ".env files not found, please provide the .env file"
    exit 1;
fi

# prepares config file
# 1. NGINX Config Files
prep_nginx
# 2. LocalSettings.php files
prep_mw

# ansible-playbook -i $1 cs-clean.yml
# ansible-playbook -i $1 cs-up.yml

echo "Installation completed"