#!/usr/bin/env bash

######################################
# Created by Pool4U for YiiMP use... #
######################################

source /etc/functions.sh
source $STORAGE_ROOT/yiimp/.yiimp.conf
source $HOME/yiimpserver/yiimp_single/.wireguard.install.cnf

echo -e "$CYAN Building blocknotify and stratum...$COL_RESET"

cd $HOME/yiimp/yiimp_setup/yiimp/blocknotify
blckntifypass=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1`
sudo sed -i 's/tu8tu5/'${blckntifypass}'/' blocknotify.cpp
hide_output sudo make
cd $HOME/yiimp/yiimp_setup/yiimp/stratum/iniparser
hide_output sudo make
cd $HOME/yiimp/yiimp_setup/yiimp/stratum
hide_output sudo sed -i 's/CFLAGS += -DNO_EXCHANGE/#CFLAGS += -DNO_EXCHANGE/' $HOME/yiimp/yiimp_setup/yiimp/stratum/Makefile
hide_output sudo make

echo -e "$CYAN Building stratum folder structure and copying files...$COL_RESET"
cd $HOME/yiimp/yiimp_setup/yiimp/stratum
sudo cp -a config.sample/. $STORAGE_ROOT/yiimp/site/stratum/config
sudo cp -r stratum $STORAGE_ROOT/yiimp/site/stratum
sudo cp -r run.sh $STORAGE_ROOT/yiimp/site/stratum

cd $HOME/yiimp/yiimp_setup/yiimp
sudo cp -r $HOME/yiimp/yiimp_setup/yiimp/blocknotify/blocknotify $STORAGE_ROOT/yiimp/site/stratum
sudo cp -r $HOME/yiimp/yiimp_setup/yiimp/blocknotify/blocknotify /usr/bin

sudo rm -r $STORAGE_ROOT/yiimp/site/stratum/config/run.sh
echo '#!/usr/bin/env bash
source /etc/yiimpserver.conf
source $STORAGE_ROOT/yiimp/.yiimp.conf
ulimit -n 10240
ulimit -u 10240
cd '""''"${STORAGE_ROOT}"''""'/yiimp/site/stratum
while true; do
./stratum config/$1
sleep 2
done
exec bash' | sudo -E tee $STORAGE_ROOT/yiimp/site/stratum/config/run.sh >/dev/null 2>&1
sudo chmod +x $STORAGE_ROOT/yiimp/site/stratum/config/run.sh

sudo rm -r $STORAGE_ROOT/yiimp/site/stratum/run.sh
echo '#!/usr/bin/env bash
source /etc/yiimpserver.conf
source $STORAGE_ROOT/yiimp/.yiimp.conf
cd '""''"${STORAGE_ROOT}"''""'/yiimp/site/stratum/config/ && ./run.sh $*
' | sudo -E tee $STORAGE_ROOT/yiimp/site/stratum/run.sh >/dev/null 2>&1
sudo chmod +x $STORAGE_ROOT/yiimp/site/stratum/run.sh

echo -e "$CYAN Updating stratum config files with database connection info...$COL_RESET"
cd $STORAGE_ROOT/yiimp/site/stratum/config

sudo sed -i 's/password = tu8tu5/password = '${blckntifypass}'/g' *.conf
sudo sed -i 's/server = yaamp.com/server = '${StratumURL}'/g' *.conf
sudo sed -i 's/host = yaampdb/host = '${DBInternalIP}'/g' *.conf
sudo sed -i 's/database = yaamp/database = '${YiiMPDBName}'/g' *.conf
sudo sed -i 's/username = root/username = '${StratumDBUser}'/g' *.conf
sudo sed -i 's/password = patofpaq/password = '${StratumUserDBPassword}'/g' *.conf

#set permissions
sudo setfacl -m u:$USER:rwx $STORAGE_ROOT/yiimp/site/stratum/
sudo setfacl -m u:$USER:rwx $STORAGE_ROOT/yiimp/site/stratum/config

echo -e "$GREEN Stratum build completed...$COL_RESET"
cd $HOME/yiimpserver/yiimp_single
