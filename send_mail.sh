#!/usr/bin/env bash

######################################
# Created by Pool4U for YiiMP use... #
######################################

source /etc/functions.sh
source /etc/yiimpserver.conf
source $STORAGE_ROOT/yiimp/.yiimp.conf

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

echo -e "$CYAN Installing mail system $COL_RESET"

hide_output sudo debconf-set-selections <<< "postfix postfix/mailname string ${PRIMARY_HOSTNAME}"
hide_output sudo debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
hide_output apt_install mailutils

hide_output sudo sed -i 's/inet_interfaces = all/inet_interfaces = loopback-only/g' /etc/postfix/main.cf
hide_output sudo sed -i 's/myhostname =/# myhostname =/g' /etc/postfix/main.cf
hide_output sudo sed -i 's/mydestination/# mydestination/g' /etc/postfix/main.cf
hide_output sudo sed -i '/# mydestination/i mydestination = $myhostname, localhost.$mydomain, localhost, $mydomain' /etc/postfix/main.cf
hide_output sudo sed -i '/# myhostname =/i myhostname = localhost' /etc/postfix/main.cf

hide_output sudo systemctl restart postfix
hide_output whoami=`whoami`

hide_output sudo sed -i '/postmaster:    root/a root:          '${SupportEmail}'' /etc/aliases
hide_output sudo sed -i '/root:/a '$whoami':     '${SupportEmail}'' /etc/aliases
hide_output sudo newaliases

hide_output sudo adduser $whoami mail
hide_output echo -e "$GREEN Mail system completed...$COL_RESET"
set +eu +o pipefail
hide_output cd $HOME/yiimpserver/yiimp_single
