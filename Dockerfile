FROM php:7.1.9-cli

RUN mkdir -p /usr/local/bin \
&& curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony \
&& chmod a+x /usr/local/bin/symfony

RUN apt-get update && apt-get install -y libpq-dev zlib1g-dev git \
&& docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
&& docker-php-ext-install pdo pdo_pgsql pgsql zip

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
&& php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
&& php composer-setup.php \
&& php -r "unlink('composer-setup.php');" \
&& mv composer.phar /usr/local/bin/composer

ENV COMPOSER_HOME /opt/.composer

RUN mkdir -p /opt/.composer \
&& chmod 0777 /opt/.composer

RUN cd /opt \
&& curl -LsS https://nodejs.org/dist/v6.11.3/node-v6.11.3-linux-x64.tar.xz -o node-v6.11.3-linux-x64.tar.xz \
&& tar -xf node-v6.11.3-linux-x64.tar.xz \
&& ln -s /opt/node-v6.11.3-linux-x64/bin/node /usr/local/bin/node \
&& ln -s /opt/node-v6.11.3-linux-x64/bin/npm /usr/local/bin/npm

RUN mkdir -p /opt/.npm \
&& chmod 0777 /opt/.npm

ENV npm_config_cache /opt/.npm

EXPOSE 8000

WORKDIR /symfony

CMD ["php", "bin/console", "server:run", "0.0.0.0:8000"]