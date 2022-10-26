#!/usr/bin/env bash

######################################
# Created by Pool4U for YiiMP use... #
######################################

source $HOME/yiimpserver/yiimp_single/.wireguard.install.cnf
source $STORAGE_ROOT/yiimp/.wireguard.conf
source /etc/yiimpserver.conf

clear
echo -e "$CYAN Installing WireGuard...$COL_RESET"
(umask 077 && printf "[Interface]\nPrivateKey = " | sudo tee /etc/wireguard/wg0.conf > /dev/null)
wg genkey | sudo tee -a /etc/wireguard/wg0.conf | wg pubkey | sudo tee /etc/wireguard/publickey

# Install WireGuard on main server.
echo "ListenPort = 50002" | sudo tee -a /etc/wireguard/wg0.conf
echo "SaveConfig = true" | sudo tee -a /etc/wireguard/wg0.conf
echo "Address = ${DBInternalIP}/24" | sudo tee -a /etc/wireguard/wg0.conf
cd $HOME
sudo systemctl start wg-quick@wg0
sudo systemctl enable wg-quick@wg0
sudo ufw allow 50002
#clear
dbpublic=${PUBLIC_IP}
mypublic="$(sudo cat /etc/wireguard/publickey)"

echo '  Public Ip: '"${dbpublic}"'
Public Key: '"${mypublic}"'
' | sudo -E tee $STORAGE_ROOT/yiimp/.wireguard_public.conf >/dev/null 2>&1;

echo -e "$GREEN WireGuard setup completed...$COL_RESET"
cd $HOME/yiimpserver/yiimp_single
