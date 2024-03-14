#!/bin/bash

# Standardwerte für PHP-Einstellungen und Shop-Installationsstatus
MEMORY_LIMIT=${PHP_MEMORY_LIMIT:-128M}
POST_MAX_SIZE=${PHP_POST_MAX_SIZE:-8M}
MAX_EXECUTION_TIME=${PHP_MAX_EXECUTION_TIME:-120}
UPLOAD_MAX_FILESIZE=${PHP_UPLOAD_MAX_FILESIZE:-6M}
APACHE_SERVER_NAME=${APACHE_SERVER_NAME:-localhost}
SHOP_INSTALLED=${SHOP_INSTALLED:-false}

# Erstelle custom-php.ini-Datei und setze PHP-Konfigurationsoptionen
echo "memory_limit = ${MEMORY_LIMIT}" > /usr/local/etc/php/conf.d/custom-php.ini
echo "post_max_size = ${POST_MAX_SIZE}" >> /usr/local/etc/php/conf.d/custom-php.ini
echo "max_execution_time = ${MAX_EXECUTION_TIME}" >> /usr/local/etc/php/conf.d/custom-php.ini
echo "upload_max_filesize = ${UPLOAD_MAX_FILESIZE}" >> /usr/local/etc/php/conf.d/custom-php.ini
echo "Apache ServerName gesetzt auf: $APACHE_SERVER_NAME"

# Setze Apache Server Name
echo "ServerName $APACHE_SERVER_NAME" >> /etc/apache2/apache2.conf

# Setze die Berechtigungen für spezifische Dateien/Ordner, sofern vorhanden
# Pfade sind relativ zu /var/www/html, daher wechseln wir zuerst in das Verzeichnis
cd /var/www/html

# Prüfe, ob die jtl-shop.zip Datei existiert und entpacke sie, falls vorhanden
if [ -f "jtl-shop.zip" ]; then
    echo "jtl-shop.zip gefunden. Entpacke..."
    unzip -o jtl-shop.zip
    echo "Entpacken abgeschlossen. Lösche jtl-shop.zip..."
    rm jtl-shop.zip
    echo "jtl-shop.zip wurde gelöscht."
fi

if [ -d "bilder" ]; then chmod -R 755 bilder/*; echo "Berechtigungen für 'bilder' gesetzt."; fi
if [ -d "dbeS/tmp" ]; then chmod -R 755 dbeS/tmp; echo "Berechtigungen für 'dbeS/tmp' gesetzt."; fi
if [ -d "dbeS/logs" ]; then chmod -R 755 dbeS/logs; echo "Berechtigungen für 'dbeS/logs' gesetzt."; fi
if [ -d "admin/templates_c" ]; then chmod -R 755 admin/templates_c; echo "Berechtigungen für 'admin/templates_c' gesetzt."; fi
if [ -d "jtllogs" ]; then chmod -R 755 jtllogs; echo "Berechtigungen für 'jtllogs' gesetzt."; fi
if [ -d "install/logs" ]; then chmod -R 755 install/logs; echo "Berechtigungen für 'install/logs' gesetzt."; fi
if [ -f "includes/config.JTL-Shop.ini.php" ]; then chmod 755 includes/config.JTL-Shop.ini.php; echo "Berechtigungen für 'includes/config.JTL-Shop.ini.php' gesetzt."; fi
if [ -d "mediafiles" ]; then chmod -R 755 mediafiles; echo "Berechtigungen für 'mediafiles' gesetzt."; fi
if [ -d "admin/includes/emailpdfs" ]; then chmod -R 755 admin/includes/emailpdfs; echo "Berechtigungen für 'admin/includes/emailpdfs' gesetzt."; fi
if [ -f "shopinfo.xml" ]; then chmod 755 shopinfo.xml; echo "Berechtigungen für 'shopinfo.xml' gesetzt."; fi
if [ -f "rss.xml" ]; then chmod 755 rss.xml; echo "Berechtigungen für 'rss.xml' gesetzt."; fi
if [ -d "uploads" ]; then chmod -R 755 uploads; echo "Berechtigungen für 'uploads' gesetzt."; fi
if [ -d "export" ]; then chmod -R 755 export; echo "Berechtigungen für 'export' gesetzt."; fi
if [ -d "media" ]; then chmod -R 755 media; echo "Berechtigungen für 'media' gesetzt."; fi

# Wenn SHOP_INSTALLED auf true gesetzt ist, führe die entsprechenden Aktionen aus
if [ "$SHOP_INSTALLED" = "true" ]; then
  # Lösche den /install Ordner, wenn vorhanden und notwendig
  if [ -d "install" ]; then 
    rm -rf install
    echo "/install Ordner wurde gelöscht."
  fi

  # Entziehe Schreibrechte für includes/config.JTL-Shop.ini.php, wenn noch vorhanden
  if [ -f "includes/config.JTL-Shop.ini.php" ]; then
    current_perms=$(stat -c "%a" includes/config.JTL-Shop.ini.php)
    if [ "$current_perms" != "644" ]; then
      chmod 644 includes/config.JTL-Shop.ini.php
      echo "Schreibrechte von 'includes/config.JTL-Shop.ini.php' entfernt."
    fi
  fi
fi

# Setze die Benutzer- und Gruppenberechtigungen für alle Dateien im /var/www/html-Ordner
chown -R www-data:www-data .
echo "Benutzer- und Gruppenberechtigungen gesetzt."

# Wechsle zurück zum ursprünglichen Verzeichnis
cd -

# Starte den Apache-Server
echo "Apache-Server wird gestartet..."
exec "$@"
