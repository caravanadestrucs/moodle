FROM php:8.1-apache

RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libicu-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    cron \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        gd \
        intl \
        mysqli \
        pdo \
        pdo_mysql \
        soap \
        xml \
        zip \
        opcache

RUN a2enmod rewrite

# Apache necesita permitir .htaccess
RUN sed -i 's|AllowOverride None|AllowOverride All|g' /etc/apache2/apache2.conf

WORKDIR /var/www/html
