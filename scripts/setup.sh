#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# Install Nginx
apt-get install -y nginx

# Get the dotdeb repo to install newest version of PHP7
echo deb http://ftp.utexas.edu/dotdeb/ stable all >> /etc/apt/sources.list
echo deb-src http://ftp.utexas.edu/dotdeb/ stable all >> /etc/apt/sources.list
wget https://www.dotdeb.org/dotdeb.gpg && apt-key add dotdeb.gpg
apt-get update
apt-get install -y php7.0-cli php7.0-curl php7.0-dev php7.0-fpm php7.0-gd php7.0-mcrypt php7.0-opcache php7.0-sqlite

# Copy over new configuration files, so the system will work properly
echo "Copying config files to new locations"
cp /tmp/config/default /etc/nginx/sites-available/default
cp /tmp/config/php.ini.cli /etc/php/7.0/cli/php.ini
cp /tmp/config/php.ini.fpm /etc/php/7.0/fpm/pnp.ini

# Copy a test index.php file, with phpinfo() as a test file
cp /tmp/html/index.php /var/www/html/index.php


# Additional shell commands to install Symfony demo go here!!!

