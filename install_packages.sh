ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
RED=$ESC_SEQ"31;01m"
GREEN=$ESC_SEQ"32;01m"
YELLOW=$ESC_SEQ"33;01m"
BLUE=$ESC_SEQ"34;01m"
MAGENTA=$ESC_SEQ"35;01m"
CYAN=$ESC_SEQ"36;01m"

echo -e "$CYAN Removing Apache and installing NGINX...$COL_RESET"
    hide_output sudo apt-get purge apache2 -y
    hide_output sudo apt-get purge apache2-* -y
    hide_output sudo apt-get --purge autoremove -y
    hide_output sudo apt-get install nginx -y
echo -e "$GREEN Done...$COL_RESET"

echo -e "$CYAN Installing MariaDB Repository...$COL_RESET"
    hide_output sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
    hide_output sudo add-apt-repository 'deb [arch=amd64,arm64,ppc64el] http://mirror.one.com/mariadb/repo/10.4/ubuntu bionic main' >/dev/null 2>&1
echo -e "$GREEN Done...$COL_RESET"

echo -e "$CYAN Install software-properties-common...$COL_RESET"
    hide_output sudo apt-get install software-properties-common -y
echo -e "$GREEN Done...$COL_RESET"

echo -e "$CYAN Install certbot...$COL_RESET"
    hide_output sudo add-apt-repository ppa:certbot/certbot -y
    hide_output sudo apt-get install python-certbot-nginx -y
    hide_output sudo apt-get install ca-certificates -y
    hide_output sudo apt-get install certbot -y
echo -e "$GREEN Done...$COL_RESET"

echo -e "$CYAN Installing ppa:bitcoin/bitcoin...$COL_RESET"
    hide_output sudo add-apt-repository ppa:bitcoin/bitcoin -y
echo -e "$GREEN Done...$COL_RESET"

echo -e "$CYAN Installing ppa:ondrej/php...$COL_RESET"
    hide_output sudo add-apt-repository ppa:ondrej/php -y
echo -e "$GREEN Done...$COL_RESET"

echo -e "$CYAN Installing ppa:wireguard/wireguard...$COL_RESET"
    hide_output sudo apt-get install wireguard -y
    hide_output sudo apt-get install wireguard-dkms -y
    #hide_output sudo apt-get install wireguard-tools -y
    #hide_output sudo add-apt-repository ppa:wireguard/wireguard -y
echo -e "$GREEN Done...$COL_RESET"

echo -e "$CYAN Installing packages*...$COL_RESET"
    hide_output sudo apt-get install git -y
    hide_output sudo apt-get install nano -y
    hide_output sudo apt-get install dialog -y
    hide_output sudo apt-get install build-essential -y
    hide_output sudo apt-get install autotools-dev -y
    hide_output sudo apt-get install automake -y
    hide_output sudo apt-get install pkg-config -y
    hide_output sudo apt-get install bsdmainutils -y
    hide_output sudo apt-get install python3 -y
    hide_output sudo apt-get install python3-dev -y
    hide_output sudo apt-get install python3-pip -y
    #hide_output sudo apt-get install wget -y
    #hide_output sudo apt-get install bc -y
    hide_output sudo apt-get install mcrypt -y
    hide_output sudo apt-get install imagemagick -y
    hide_output sudo apt-get install memcached -y
    hide_output sudo apt-get install curl -y
    hide_output sudo apt-get install zip -y
    hide_output sudo apt-get install unzip -y
    hide_output sudo apt-get install rar -y
    #hide_output sudo apt-get install vim -y
    hide_output sudo apt-get install fail2ban -y
    hide_output sudo apt-get install ufw -y
    hide_output sudo apt-get install qttools5-dev -y
    hide_output sudo apt-get install qttools5-dev-tools -y
    #hide_output sudo apt-get install qtbase5-dev -y
    hide_output sudo apt-get install protobuf-compiler -y
    hide_output sudo apt-get install update-motd -y
    hide_output sudo apt-get install haveged -y
    #hide_output sudo apt-get install coreutils -y
    #hide_output sudo apt-get install pollinate -y
    #hide_output sudo apt-get install unattended-upgrades -y
    #hide_output sudo apt-get install cron -y
    hide_output sudo apt-get install pwgen -y
    #hide_output sudo apt-get install rsyslog -y
    hide_output sudo apt-get install cmake -y
    hide_output sudo apt-get install gnupg2 -y
    #hide_output sudo apt-get install acl -y
    #hide_output sudo apt-get install update-notifier-common -y
    #hide_output sudo apt-get install lsb-release -y
    #hide_output sudo apt-get install landscape-common -y
    #hide_output sudo apt-get install screen -y
    hide_output sudo apt-get install cifs-utils -y
    hide_output sudo apt-get install traceroute -y
    hide_output sudo apt-get install bison -y
    hide_output sudo apt-get install xcb-proto -y
    #hide_output sudo apt-get install x11proto-xext-dev -y
    #hide_output sudo apt-get install x11proto-dev -y
    #hide_output sudo apt-get install xtrans-dev -y
    hide_output sudo apt-get install zlib1g-dev -y
    #hide_output sudo apt-get install autoconf -y
    hide_output sudo apt-get install dh-autoreconf -y
    hide_output sudo apt-get install apt-transport-https -y
    hide_output sudo apt-get install gnutls-dev -y
    hide_output sudo apt-get install figlet -y
    hide_output sudo apt-get install sendmail -y
    hide_output sudo apt-get install ntp -y
    hide_output sudo apt-get install ntpdate -y
echo -e "$GREEN Done...$COL_RESET"

echo -e "$CYAN Installing lib*...$COL_RESET"
    hide_output sudo apt-get install libdb4.8-dev -y
    hide_output sudo apt-get install libdb4.8++-dev -y
    hide_output sudo apt-get install libdb5.1 -y
    hide_output sudo apt-get install libdb5.1++ -y
    hide_output sudo apt-get install libdb5.3 -y
    hide_output sudo apt-get install libdb5.3++ -y
    hide_output sudo apt-get install libdb5.3++-dev -y
    hide_output sudo apt-get install libtool -y
    hide_output sudo apt-get install libssl-dev -y
    hide_output sudo apt-get install libevent-dev -y
    hide_output sudo apt-get install libboost-system-dev -y
    hide_output sudo apt-get install libboost-filesystem-dev -y
    hide_output sudo apt-get install libboost-chrono-dev -y
    hide_output sudo apt-get install libboost-test-dev -y
    hide_output sudo apt-get install libboost-thread-dev -y
    hide_output sudo apt-get install libboost-all-dev -y
    hide_output sudo apt-get install libcurl4-gnutls-dev -y
    hide_output sudo apt-get install libruby -y
    hide_output sudo apt-get install libminiupnpc-dev -y
    hide_output sudo apt-get install libzmq3-dev -y
    hide_output sudo apt-get install libgmp-dev -y
    hide_output sudo apt-get install libqrencode-dev -y
    hide_output sudo apt-get install libboost-program-options1.65.1 -y
    hide_output sudo apt-get install libqt5gui5 -y
    hide_output sudo apt-get install libqt5core5a -y
    hide_output sudo apt-get install libqt5dbus5 -y
    hide_output sudo apt-get install libprotobuf-dev -y
    hide_output sudo apt-get install libgmp3-dev -y
    hide_output sudo apt-get install libmysqlclient-dev -y
    hide_output sudo apt-get install libkrb5-dev -y
    hide_output sudo apt-get install libldap2-dev -y
    hide_output sudo apt-get install libidn11-dev -y
    hide_output sudo apt-get install librtmp-dev -y
    hide_output sudo apt-get install libpsl-dev -y
    hide_output sudo apt-get install libnghttp2-dev -y
    hide_output sudo apt-get install libsodium-dev -y
    hide_output sudo apt-get install libssh2-1 -y
    hide_output sudo apt-get install libssh2-1-dev -y
    hide_output sudo apt-get install libboost-program-options-dev -y
    hide_output sudo apt-get install libexpat1-dev -y
    hide_output sudo apt-get install libdbus-1-dev -y
    hide_output sudo apt-get install libfontconfig-dev -y
    hide_output sudo apt-get install libfreetype6-dev -y
    hide_output sudo apt-get install libice-dev -y
    hide_output sudo apt-get install libsm-dev -y
    hide_output sudo apt-get install libx11-dev -y
    hide_output sudo apt-get install libxau-dev -y
    hide_output sudo apt-get install libxext-dev -y
    hide_output sudo apt-get install libxcb1-dev -y
    hide_output sudo apt-get install libxkbcommon-dev -y
    hide_output sudo apt-get install libczmq-dev -y
    hide_output sudo apt-get install libiniparser-dev -y
echo -e "$GREEN Done...$COL_RESET"

echo -e "$CYAN Installing php*...$COL_RESET"
    hide_output sudo apt-get install php7.3 -y
    hide_output sudo apt-get install php7.3-fpm -y
    hide_output sudo apt-get install php7.3-opcache -y
    hide_output sudo apt-get install php7.3-common -y
    hide_output sudo apt-get install php7.3-gd -y
    hide_output sudo apt-get install php7.3-mysql -y
    hide_output sudo apt-get install php7.3-imap -y
    #hide_output sudo apt-get install php7.3-cli -y
    hide_output sudo apt-get install php7.3-cgi -y
    hide_output sudo apt-get install php7.3-curl -y
    hide_output sudo apt-get install php7.3-intl -y
    hide_output sudo apt-get install php7.3-pspell -y
    hide_output sudo apt-get install php7.3-recode -y
    hide_output sudo apt-get install php7.3-sqlite3 -y
    hide_output sudo apt-get install php7.3-tidy -y
    hide_output sudo apt-get install php7.3-xmlrpc -y
    hide_output sudo apt-get install php7.3-xsl -y
    hide_output sudo apt-get install php7.3-zip -y
    hide_output sudo apt-get install php7.3-mbstring -y
    hide_output sudo apt-get install php7.3-memcache -y
    hide_output sudo apt-get install php7.3-memcached -y
    hide_output sudo apt-get install php-pear -y
    hide_output sudo apt-get install php-auth-sasl -y
    hide_output sudo apt-get install php-memcache -y
    hide_output sudo apt-get install php-imagick -y
    hide_output sudo apt-get install php-gettext -y
    #hide_output sudo apt-get install phpmyadmin -y
echo -e "$GREEN Done...$COL_RESET"

echo -e "$CYAN Installing updates/upgades for packages...$COL_RESET"
    hide_output sudo apt update -y
    hide_output sudo apt upgrade -y
echo -e "$GREEN Done...$COL_RESET"
