FROM php:8.1-fpm-alpine3.15

ENV PATH "$PATH:/var/www/html/vendor/bin"

ENV PHP_GD_DEPS "freetype-dev libjpeg-turbo-dev libpng-dev"

# Set up PHP with modules and ini settings for running WordPress
RUN apk update \
    && apk add --no-cache $PHP_GD_DEPS icu-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install gd mysqli pdo pdo_mysql intl \
    && docker-php-ext-enable opcache

COPY ../php-custom.ini /usr/local/etc/php/

RUN apk update && apk add --virtual --no-cache \
    imagemagick imagemagick-dev $PHPIZE_DEPS \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && apk del imagemagick-dev $PHPIZE_DEPS
