FROM php:8.2-fpm-alpine

ENV PATH "$PATH:/var/www/html/vendor/bin"

ENV PHP_GD_DEPS "freetype-dev libjpeg-turbo-dev libpng-dev"

# Set up PHP with modules and ini settings for running WordPress
RUN apk update \
    && apk add --no-cache $PHP_GD_DEPS icu-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install gd mysqli pdo pdo_mysql intl \
    && echo "date.timezone=Europe/London" > /usr/local/etc/php/conf.d/zz-custom.ini \
    && echo "session.autostart=0" >> /usr/local/etc/php/conf.d/zz-custom.ini \
    && echo "post_max_size=16M" >> /usr/local/etc/php/conf.d/zz-custom.ini \
    && echo "upload_max_filesize=16M" >> /usr/local/etc/php/conf.d/zz-custom.ini

RUN apk update && apk add --virtual --no-cache \
    imagemagick imagemagick-dev $PHPIZE_DEPS \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && apk del imagemagick-dev $PHPIZE_DEPS
