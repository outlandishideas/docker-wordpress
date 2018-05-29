FROM php:7.1-fpm


RUN echo "date.timezone=Europe/London" > /usr/local/etc/php/conf.d/zz-custom.ini \
    && echo "error_reporting = E_ALL" >> /usr/local/etc/php/conf.d/zz-custom.ini \
    && echo "display_errors = on" >> /usr/local/etc/php/conf.d/zz-custom.ini \
    && echo "session.autostart=0" >> /usr/local/etc/php/conf.d/zz-custom.ini
    
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen en_US.utf8 \
	&& /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

ENV PATH "$PATH:/var/www/html/vendor/bin"

RUN apt-get update \
    && apt-get install -y \
    && docker-php-ext-install mysqli pdo pdo_mysql mbstring

RUN apt-get update \
    && apt-get install -y \
        libicu-dev \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install intl \
    && apt-get remove -y \
        libicu-dev \
    && apt-get install -y \
        libicu52 \
    && apt-get autoremove -y
    
RUN apt-get update \
    && apt-get install libcurl4-openssl-dev -y \
    && docker-php-ext-install curl \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false libcurl4-openssl-dev -y

RUN apt-get update \
    && apt-get install libxml2-dev -y \
    && docker-php-ext-install xml \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false libxml2-dev -y
    
RUN apt-get update \
    && apt-get install -y \
        zlib1g-dev \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install zip \
    && apt-get remove -y \
        zlib1g-dev \
    && apt-get install -y \
        zlib1g \
    && apt-get autoremove -y

RUN apt-get update \
    && apt-get install -y \
        libmcrypt-dev \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install mcrypt \
    && apt-get remove -y \
        libmcrypt-dev \
    && apt-get install -y \
        libmcrypt4 \
    && apt-get autoremove -

RUN apt-get update \
    && apt-get install -y --no-install-recommends libmagickwand-dev \
    && rm -rf /var/lib/apt/lists/* \
    && pecl install imagick-3.4.3 \
    && docker-php-ext-enable imagick

