FROM php:8.1-apache

# Dependencias necesarias para Moodle
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
        gd intl mysqli pdo pdo_mysql soap xml zip opcache

# Apache modules necesarios
RUN a2enmod rewrite

# Permitir .htaccess
RUN sed -i 's|AllowOverride None|AllowOverride All|g' /etc/apache2/apache2.conf

# index.php primero
RUN sed -i 's/DirectoryIndex .*/DirectoryIndex index.php index.html/' /etc/apache2/mods-enabled/dir.conf

# 👇 VirtualHost CORRECTO para Moodle (PUBLIC)
RUN echo '<VirtualHost *:80>
    DocumentRoot /var/www/html/public

    <Directory /var/www/html/public>
        Options FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    <Directory /var/www/html>
        Require all denied
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/000-default.conf

# 👇 Copiar Moodle a la imagen
COPY . /var/www/html

# 👇 Directorios y permisos
RUN mkdir -p /var/www/moodledata /var/www/html/config \
 && chown -R www-data:www-data /var/www/html /var/www/moodledata \
 && chmod -R 755 /var/www/html \
 && chmod -R 777 /var/www/moodledata

WORKDIR /var/www/html
