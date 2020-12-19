#!/bin/bash

[ "$DEBUG" = "true" ] && set -x

chown www-data:www-data /var/www

[ "$PHP_ENABLE_XDEBUG" = "true" ] && \
    docker-php-ext-enable xdebug && \
    echo "xdebug.remote_host=$PHP_XDEBUG_REMOTE" >> $PHP_INI_DIR/conf.d/zz-xdebug-settings.ini && \
    echo "Xdebug is enabled"

exec "$@"