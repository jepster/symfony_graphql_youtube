FROM alpine:latest AS production

# Update and install system dependencies
RUN apk update && \
    apk upgrade && \
    apk add bash nginx supervisor php82-pecl-ssh2 php82-session git openssh-client \
            php82 php82-fpm php82-phar php82-iconv php82-mbstring php82-openssl php82-ctype php82-simplexml php82-xml \
            php82-xmlwriter php82-dom php82-tokenizer php82-pecl-amqp php82-curl php82-opcache

# Copy configs
COPY ./container/resources/supervisor/supervisord.conf /etc/
COPY ./container/resources/nginx/nginx.conf            /etc/nginx/
COPY ./container/resources/nginx/default.conf          /etc/nginx/http.d/
COPY ./container/resources/php/php-fpm.conf            /etc/php82/php-fpm.d/zz-php-fpm.conf
COPY ./container/resources/php/docker.conf             /etc/php82/php-fpm.d/zz-docker.conf
COPY ./container/resources/php/opcache.ini             /etc/php82/conf.d/50_opcache.ini

# Set symlink for PHP
RUN ln -s /usr/bin/php82 /usr/bin/php

# Install composer from the official image
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/application

# Add code
COPY ./symfony /var/www/application

# Run composer install to install the dependencies
RUN composer install --no-cache --no-interaction --optimize-autoloader

# Do not run as root user
RUN chown -R 1000:1000 /var/www/application && \
    chown -R 1000:1000 /var/lib/nginx
USER nobody

# Open port
EXPOSE 8080

## Supervisor starts our nginx and php-fpm
ENTRYPOINT  bin/console cache:clear && \
            supervisord -c /etc/supervisord.conf

FROM production AS development

# Switch the root user
USER root

# Install dev dependencies
RUN apk add php82-pecl-xdebug

## Do not run as root user
USER nobody

# Copy configs
COPY ./container/resources/php/opcache-dev.ini  /etc/php82/conf.d/50_opcache.ini
COPY ./container/resources/php/xdebug.ini       /etc/php82/conf.d/50_xdebug.ini
COPY ./container/resources/php/custom_dev.ini  /etc/php82/conf.d/90_custom.ini
