FROM php:8.1-fpm

RUN apt update \
    && apt install -y zlib1g-dev g++ git libicu-dev zip libzip-dev zip \
    && docker-php-ext-install intl opcache pdo pdo_mysql \
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip \
      && (curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer) \
      # install gmp
      && apt-get update -y \
      && apt-get install -y libgmp-dev re2c libmhash-dev libmcrypt-dev file \
      && ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/local/include/ \
      && docker-php-ext-configure gmp \
      && docker-php-ext-install gmp

WORKDIR /var/www/rd

#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN mv /root/.symfony/bin/symfony /usr/local/bin/symfony
RUN git config --global user.email "basarskiy@gmail.com" \
    && git config --global user.name "Viktor"

RUN apt-get update && apt-get install -y nodejs npm
