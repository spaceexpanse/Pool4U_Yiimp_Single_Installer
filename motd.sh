#!/usr/bin/env bash

######################################
# Created by Pool4U for YiiMP use... #
######################################

source /etc/functions.sh # load our functions
source /etc/yiimpserver.conf

#apt_install lsb-release figlet update-motd \
#landscape-common update-notifier-common
hide_output cd $HOME/yiimpserver/yiimp_single/ubuntu/etc/update-motd.d
hide_output sudo rm -r /etc/update-motd.d/
hide_output sudo mkdir /etc/update-motd.d/
hide_output sudo touch /etc/update-motd.d/00-header ; sudo touch /etc/update-motd.d/10-sysinfo ; sudo touch /etc/update-motd.d/90-footer
hide_output sudo chmod +x /etc/update-motd.d/*
hide_output sudo cp -r 00-header 10-sysinfo 90-footer /etc/update-motd.d/


hide_output cd $HOME/yiimpserver/yiimp_single/ubuntu
# copy additional files
hide_output sudo cp -r screens /usr/bin/
hide_output sudo chmod +x /usr/bin/screens
hide_output sudo cp -r stratum /usr/bin
hide_output sudo chmod +x /usr/bin/stratum
hide_output sudo cp -r addport /usr/bin
hide_output sudo chmod +x /usr/bin/addport
echo '
#clear
run-parts /etc/update-motd.d/ | sudo tee /etc/motd
' | sudo -E tee /usr/bin/motd >/dev/null 2>&1

hide_output sudo chmod +x /usr/bin/motd
hide_output cd $HOME/yiimpserver/yiimp_single
