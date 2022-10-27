#!/usr/bin/env bash

######################################
# Created by Pool4U for YiiMP use... #
######################################

source /etc/functions.sh
source $STORAGE_ROOT/yiimp/.yiimp.conf
cd $HOME/yiimpserver/yiimp_single

set -eu -o pipefail

function print_error {
    read line file <<<$(caller)
    echo "An error occurred in line $line of file $file:" >&2
    sed "${line}q;d" "$file" >&2
}
trap print_error ERR

#if [[ ("$wireguard" == "true") ]]; then
source $STORAGE_ROOT/yiimp/.wireguard.conf
#fi

# NGINX upgrade
echo -e "$CYAN Upgrading NGINX...$COL_RESET"

#Grab Nginx key and proper mainline package for distro
echo "deb http://nginx.org/packages/mainline/ubuntu `lsb_release -cs` nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list >/dev/null 2>&1

sudo curl -fsSL https://nginx.org/keys/nginx_signing.key | sudo apt-key add - >/dev/null 2>&1
#sudo apt-get nginx -y

# Make additional conf directories, move and generate needed configurations.
sudo mkdir -p /etc/nginx/yiimp.server
sudo mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.old
sudo cp -r nginx_confs/nginx.conf /etc/nginx/
sudo cp -r nginx_confs/general.conf /etc/nginx/yiimp.server
sudo cp -r nginx_confs/php_fastcgi.conf /etc/nginx/yiimp.server
sudo cp -r nginx_confs/security.conf /etc/nginx/yiimp.server
sudo cp -r nginx_confs/letsencrypt.conf /etc/nginx/yiimp.server

# Removing default nginx site configs.
if [ -f /etc/nginx/conf.d/default.conf ]; then
    sudo rm -r /etc/nginx/conf.d/default.conf
else
    echo File: /etc/nginx/conf.d/default.conf does not exist!!!
fi
if [ -f /etc/nginx/sites-enabled/default* ]; then
    sudo rm -r /etc/nginx/sites-enabled/default*
else
    echo File: /etc/nginx/sites-enabled/default* does not exist!!!
fi
if [ -f /etc/nginx/sites-available/default* ]; then
    sudo rm -r /etc/nginx/sites-available/default*
else
    echo File: /etc/nginx/sites-available/default* does not exist!!!
fi

echo -e "$GREEN NGINX upgrade complete...$COL_RESET"
restart_service nginx
restart_service php7.3-fpm
set +eu +o pipefail
cd $HOME/yiimpserver/yiimp_single
