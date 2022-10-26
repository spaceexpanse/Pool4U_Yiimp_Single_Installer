#!/usr/bin/env bash

######################################
# Created by Pool4U for YiiMP use... #
######################################

source /etc/functions.sh
source /etc/yiimpserver.conf
source $STORAGE_ROOT/yiimp/.yiimp.conf
source $HOME/yiimpserver/yiimp_single/.wireguard.install.cnf

set -eu -o pipefail

function print_error {
    read line file <<<$(caller)
    echo "An error occurred in line $line of file $file:" >&2
    sed "${line}q;d" "$file" >&2
}
trap print_error ERR

sudo mkdir -p $HOME/yiimp/yiimp_setup/tmp
cd $HOME/yiimp/yiimp_setup/tmp
echo -e "$GREEN Additional System Files Completed...$COL_RESET"

echo -e " Building OpenSSL 1.0.2g, this may take several minutes...$COL_RESET"
cd $HOME/yiimp/yiimp_setup/tmp
hide_output sudo wget https://www.openssl.org/source/old/1.0.2/openssl-1.0.2g.tar.gz --no-check-certificate
hide_output sudo tar -xf openssl-1.0.2g.tar.gz
cd openssl-1.0.2g
hide_output sudo ./config --prefix=$STORAGE_ROOT/openssl --openssldir=$STORAGE_ROOT/openssl shared zlib
hide_output sudo make
hide_output sudo make install
cd $HOME/yiimp/yiimp_setup/tmp
sudo rm -r openssl-1.0.2g.tar.gz openssl-1.0.2g
echo -e "$GREEN OpenSSL 1.0.2g Completed...$COL_RESET"

echo -e " Building bls-signatures, this may take several minutes...$COL_RESET"
cd $HOME/yiimp/yiimp_setup/tmp
hide_output sudo wget 'https://github.com/mivanoski/Pool4U_bls-signatures/releases/download/1.0/v20181101.zip'
hide_output sudo unzip v20181101.zip
cd bls-signatures-20181101
hide_output sudo cmake .
hide_output sudo make install
cd $HOME/yiimp/yiimp_setup/tmp
sudo rm -r v20181101.zip bls-signatures-20181101
echo -e "$GREEN bls-signatures Completed...$COL_RESET"

echo -e " Building blocknotify.sh...$COL_RESET"
source $STORAGE_ROOT/yiimp/.wireguard.conf
echo '######################################
# Created by Pool4U for YiiMP use... #
######################################
#!/bin/bash
blocknotify '""''"${DBInternalIP}"''""':$1 $2 $3' | sudo -E tee /usr/bin/blocknotify.sh >/dev/null 2>&1
sudo chmod +x /usr/bin/blocknotify.sh

echo
echo -e "$GREEN Daemon setup completed...$COL_RESET"

set +eu +o pipefail
cd $HOME/yiimpserver/yiimp_single
