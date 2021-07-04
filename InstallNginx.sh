#! /bin/bash

apt-get update
apt-get install nginx -y

unlink /etc/nginx/sites-enabled/default

cp ./resources/reverse-proxy.conf /etc/nginx/sites-available/.

ln -s /etc/nginx/sites-available/reverse-proxy.conf /etc/nginx/sites-enabled/reverse-proxy.conf

add-apt-repository ppa:certbot/certbot -y

apt install -y python3-certbot-nginx

nginx -t

systemctl reload nginx
