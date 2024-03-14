#!/bin/bash

# Standardwerte für PHP-Einstellungen
MEMORY_LIMIT=${PHP_MEMORY_LIMIT:-128M}
POST_MAX_SIZE=${PHP_POST_MAX_SIZE:-8M}
MAX_EXECUTION_TIME=${PHP_MAX_EXECUTION_TIME:-120}
UPLOAD_MAX_FILESIZE=${PHP_UPLOAD_MAX_FILESIZE:-6M}
APACHE_SERVER_NAME=${APACHE_SERVER_NAME:-localhost}

# Erstelle custom-php.ini-Datei und setze PHP-Konfigurationsoptionen
echo "memory_limit = ${MEMORY_LIMIT}" > /usr/local/etc/php/conf.d/custom-php.ini
echo "post_max_size = ${POST_MAX_SIZE}" >> /usr/local/etc/php/conf.d/custom-php.ini
echo "max_execution_time = ${MAX_EXECUTION_TIME}" >> /usr/local/etc/php/conf.d/custom-php.ini
echo "upload_max_filesize = ${UPLOAD_MAX_FILESIZE}" >> /usr/local/etc/php/conf.d/custom-php.ini

# Setze Apache Server Name
echo "ServerName $APACHE_SERVER_NAME" >> /etc/apache2/apache2.conf

# Setze die Berechtigungen für spezifische Dateien/Ordner, sofern vorhanden
if [ -d "bilder" ]; then chmod -R 755 bilder/*; fi
if [ -d "dbeS/tmp" ]; then chmod -R 755 dbeS/tmp; fi
if [ -d "dbeS/logs" ]; then chmod -R 755 dbeS/logs; fi
if [ -d "admin/templates_c" ]; then chmod -R 755 admin/templates_c; fi
if [ -d "jtllogs" ]; then chmod -R 755 jtllogs; fi
if [ -d "install/logs" ]; then chmod -R 755 install/logs; fi
if [ -f "includes/config.JTL-Shop.ini.php" ]; then chmod 755 includes/config.JTL-Shop.ini.php; fi
if [ -d "mediafiles" ]; then chmod -R 755 mediafiles; fi
if [ -d "admin/includes/emailpdfs" ]; then chmod -R 755 admin/includes/emailpdfs; fi
if [ -f "shopinfo.xml" ]; then chmod 755 shopinfo.xml; fi
if [ -f "rss.xml" ]; then chmod 755 rss.xml; fi
if [ -d "uploads" ]; then chmod -R 755 uploads; fi
if [ -d "export" ]; then chmod -R 755 export; fi
if [ -d "media" ]; then chmod -R 755 media; fi

# Setze die Benutzer- und Gruppenberechtigungen für alle Dateien im /var/www/html-Ordner
chown -R www-data:www-data /var/www/html/*

# Starte den Apache-Server
exec "$@"
