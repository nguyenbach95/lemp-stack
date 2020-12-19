FROM php:7.3-fpm

RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libicu-dev \
    libsodium-dev \
    libxml2-dev \
    libxslt-dev \
    libzip-dev \
    git vim unzip cron \
    --no-install-recommends \
    && rm -r /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-jpeg-dir=/usr/lib \
    --with-freetype-dir=/usr/include/freetype2 \
    && docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-configure intl \
    && docker-php-ext-install -j$(nproc) intl

RUN docker-php-ext-install -j$(nproc) \
    opcache \
    bcmath \
    pdo_mysql \
    soap \
    xsl \
    zip \
    sockets \
    sodium

# Install PHP Xdebug 2.9.8
RUN pecl install -o xdebug-2.9.8

# Install Latest Composer 1
RUN curl https://getcomposer.org/composer-1.phar -o composer \
  && mv composer /usr/local/bin/composer && chmod 750 /usr/local/bin/composer

RUN cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

ADD etc/docker-php.ini $PHP_INI_DIR/conf.d/
ADD etc/docker-php-xdebug.ini $PHP_INI_DIR/conf.d/zz-xdebug-settings.ini

ADD php.docker-entroypoint.sh /usr/local/bin/

RUN ["chmod", "+x", "/usr/local/bin/php.docker-entroypoint.sh"]

ENTRYPOINT [ "/usr/local/bin/php.docker-entroypoint.sh" ]

CMD ["php-fpm"]