# Verwende das offizielle PHP-Apache-Image als Basis
FROM php:8.2-apache

# Setze Arbeitsverzeichnis
WORKDIR /var/www/html

# Aktiviere Apache mod_rewrite
RUN a2enmod rewrite

# Installiere die erforderlichen PHP-Module
RUN apt-get update && apt-get install -y \
    unzip \
    imagemagick \
    curl \
    libxml2 \
    libcurl4-openssl-dev \
    libmagickwand-dev \
    libicu-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libzip-dev \
    zip \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install zip \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install soap \
    && docker-php-ext-install pdo_mysql

# Öffne Port 80 für HTTP-Zugriff
EXPOSE 80

# Kopiere das Skript zum Setzen der PHP-Einstellungen
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Setze die erforderlichen Berechtigungen
RUN chmod +x /usr/local/bin/entrypoint.sh

# Setze entrypoint.sh als Einstiegspunkt und CMD als Standardbefehl
ENTRYPOINT ["entrypoint.sh"]
CMD ["apache2-foreground"]
