#!/usr/bin/env bash

######################################
# Created by Pool4U for YiiMP use... #
######################################

#clear
source /etc/functions.sh
source $STORAGE_ROOT/yiimp/.yiimp.conf
source $HOME/yiimpserver/yiimp_single/.wireguard.install.cnf

set -eu -o pipefail

function print_error {
    read line file <<<$(caller)
    echo "An error occurred in line $line of file $file:" >&2
    sed "${line}q;d" "$file" >&2
}
trap print_error ERR

if [[ ("$wireguard" == "true") ]]; then
    source $STORAGE_ROOT/yiimp/.wireguard.conf
fi

if [[ ("$UsingDomain" == "yes") ]]; then
    echo ${DomainName} | sudo tee -a /etc/hostname
    sudo hostname "${DomainName}"
fi

# Set timezone
echo -e "$CYAN Setting TimeZone to Europe/Skopje...$COL_RESET"
if [ ! -f /etc/timezone ]; then
    echo "Setting timezone to Europe/Skopje."
    echo "Europe/Skopje" > sudo /etc/timezone
    restart_service rsyslog
fi
echo -e "$GREEN Done...$COL_RESET"

# Add repository
echo -e "$CYAN Adding the required repsoitories...$COL_RESET"
if [ ! -f /usr/bin/add-apt-repository ]; then
    echo " Installing add-apt-repository..."
    #sudo apt-get -y update
    apt_install software-properties-common
fi
echo -e "$GREEN Done...$COL_RESET"

echo -e "$CYAN Upgrading system packages...$COL_RESET"
if [ ! -f /boot/grub/menu.lst ]; then
    echo " Installing add-apt-repository..."
    #apt_get_quiet upgrade
else
    sudo rm /boot/grub/menu.lst
    sudo update-grub-legacy-ec2 -y
    apt_get_quiet upgrade
fi
echo -e "$GREEN Done...$COL_RESET"
echo -e "$CYAN Running Dist-Upgrade...$COL_RESET"
apt_get_quiet dist-upgrade
echo -e "$GREEN Done...$COL_RESET"

echo -e "$CYAN Initializing system random number generator...$COL_RESET"
dd if=/dev/random of=/dev/urandom bs=1 count=32 2> /dev/null
sudo pollinate -q -r
echo -e "$GREEN Done...$COL_RESET"

echo -e "$CYAN Initializing UFW Firewall...$COL_RESET"
set +eu +o pipefail
if [ -z "${DISABLE_FIREWALL:-}" ]; then
    # Install `ufw` which provides a simple firewall configuration.
    # apt_install ufw

    # Allow incoming connections to SSH.
    ufw_allow ssh;
    ufw_allow http;
    ufw_allow https;
    # ssh might be running on an alternate port. Use sshd -T to dump sshd's #NODOC
    # settings, find the port it is supposedly running on, and open that port #NODOC
    # too. #NODOC
    SSH_PORT=$(sshd -T 2>/dev/null | grep "^port " | sed "s/port //") #NODOC
    if [ ! -z "$SSH_PORT" ]; then
        if [ "$SSH_PORT" != "22" ]; then

            echo Opening alternate SSH port $SSH_PORT. #NODOC
            ufw_allow $SSH_PORT;
            ufw_allow http;
            ufw_allow https;

        fi
    fi

    sudo ufw --force enable;
fi #NODOC
set -eu -o pipefail
echo -e "$GREEN Done...$COL_RESET"
echo -e "$CYAN Installing YiiMP Required system packages...$COL_RESET"
if [ -f /usr/sbin/apache2 ]; then
    echo Removing apache...
    sudo apt-get purge apache2 apache2-* -y
    #apt-get -y --purge autoremove
fi

# ### Suppress Upgrade Prompts
# When Ubuntu 20 comes out, we don't want users to be prompted to upgrade,
# because we don't yet support it.
if [ -f /etc/update-manager/release-upgrades ]; then
    sudo editconf.py /etc/update-manager/release-upgrades Prompt=never
    sudo rm -f /var/lib/ubuntu-release-upgrader/release-upgrade-available
fi

echo -e "$GREEN Done...$COL_RESET"

echo -e "$CYAN Downloading Pool4U YiiMP Repo...$COL_RESET"
sudo git clone ${YiiMPRepo} $HOME/yiimp/yiimp_setup/yiimp
cd $HOME/yiimp/yiimp_setup/yiimp
sudo git fetch
sudo git checkout next >/dev/null 2>&1
cd $HOME/
if [ $USER == "root" ]; then
    sudo chown -R pool:pool /home/$SUDO_USER/yiimp/
    #echo jas sum kako root ama so user ...... $SUDO_USER
else
    sudo chown -R pool:pool /home/$USER/yiimp/
    #echo jas sum obicen user......... $USER
fi
cd $HOME/yiimp/yiimp_setup/yiimp
echo -e "$GREEN System files installed...$COL_RESET"

set +eu +o pipefail
cd $HOME/yiimpserver/yiimp_single
