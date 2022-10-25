#!/usr/bin/env bash

######################################
# Created by Pool4U for YiiMP use... #
######################################

source /etc/functions.sh

RESULT=2

#clear
;
echo 'wireguard='true'
' | sudo -E tee $HOME/yiimpserver/yiimp_single/.wireguard.install.cnf >/dev/null 2>&1;
echo 'server_type='db'
DBInternalIP='10.0.0.2'
' | sudo -E tee $STORAGE_ROOT/yiimp/.wireguard.conf >/dev/null 2>&1;
