Start (restart) docker: `docker-compose up -d`

Default nginx mount file on `/var/www`

Sites setting (virtual host) mount on `config/nginx/conf.d`

Default mysql mount file on `/var/lib/mysql`

Mysql user/pass: `root/root` 

config file is in `config/mysql/custom.cnf`

Launch mysql docker container

```
$ docker-compose exec mysql bash
$ mysql -h 127.0.0.1 -uroot -p
```

List service: `php73`, `nginx`, `mysql`, `phpmyadmin`, `redis`, `elasticsearch`, `mailhog`

#### Quick start
```
$ cp .env.example .env
$ docker-compose up -d
$ docker-compose exec php73 bash
$ cd /var/www/glamira2
$ composer install
```

#### Configuration
- `APP_NAME`: Name of project
- `WORKING_DIR`:  The directory to which project should be installed
- `VOLUME_DATA_MYSQL`: Folder mount mysql data
- `VOLUME_DATA_ELASTICSEARCH`: Folder mount elasticsearch data

**If you want to enable xdebug**

Please change:
- `PHP_ENABLE_XDEBUG` to `true`
- `PHP_XDEBUG_REMOTE` to `your ip local`: Example: `192.168.31.50`

#### How to install (Don't forget import database)
```
$ php bin/magento setup:install \
    --base-url=YOUR_DOMAIN \
    --db-host=mysql \
    --db-name=YOUR_DATABASE_NAME \
    --db-user=root \
    --db-password=root \
    --search-engine=elasticsearch7 \
    --elasticsearch-host=elasticsearch \
    --elasticsearch-port=9200
$ bin/magento se:up
$ bin/magento s:d:c
$ bin/magento s:s:d -f
$ chmod 777 -R var/ generated/ pub/
```