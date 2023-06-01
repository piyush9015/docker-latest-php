FROM php:8.1-fpm

# Arguments defined in docker-compose.yml
ARG user
ARG uid

RUN cd /usr/local/etc/php/conf.d/ && \
  echo 'memory_limit = -1' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini

ADD conf/php.ini /usr/local/etc/php

RUN apt-get update && apt-get install -y software-properties-common

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libxslt-dev \
    libzip-dev \
    zip \
    unzip \
    vim \
    libmagickwand-dev \
    libmagickcore-dev \
    net-tools

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*


#########################################################################

RUN apt update
RUN apt upgrade -y
RUN apt install -y apt-utils
RUN apt install -y libmcrypt-dev
RUN apt install -y libicu-dev
RUN docker-php-ext-install -j$(nproc) intl
RUN docker-php-ext-install -j$(nproc) gd    
RUN apt install -y libxml2-dev 
RUN apt install -y libldb-dev
RUN apt install -y libldap2-dev 
RUN apt install -y libxml2-dev
RUN apt install -y libssl-dev
RUN apt install -y libxslt-dev
RUN apt install -y libpq-dev
RUN docker-php-ext-install xsl
RUN apt install -y libsqlite3-dev
RUN apt install -y libsqlite3-0
RUN apt install -y libc-client-dev
RUN apt install -y libkrb5-dev
RUN apt install -y libcurl3-dev
RUN apt install -y firebird-dev
RUN apt-get install -y libpspell-dev
RUN apt-get install -y aspell-en
RUN apt-get install -y aspell-de  
RUN apt install -y libtidy-dev
RUN apt install -y libsnmp-dev
RUN apt install -y librecode0
RUN apt install -y librecode-dev
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer
RUN docker-php-ext-install opcache
RUN yes | pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini
RUN docker-php-ext-install soap
RUN docker-php-ext-install ftp
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install calendar
RUN docker-php-ext-install ctype
RUN docker-php-ext-install dba
RUN docker-php-ext-install dom
RUN docker-php-ext-install zip
RUN docker-php-ext-install session
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu
RUN docker-php-ext-install ldap
#RUN docker-php-ext-install json
RUN docker-php-ext-install sockets
RUN docker-php-ext-install pdo
RUN docker-php-ext-install mbstring
#RUN docker-php-ext-install tokenizer
RUN docker-php-ext-install pgsql
RUN docker-php-ext-install pdo_pgsql
RUN docker-php-ext-install pdo_mysql 
RUN docker-php-ext-install pdo_sqlite
RUN docker-php-ext-install intl
RUN docker-php-ext-install mysqli
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl
RUN docker-php-ext-install imap
RUN docker-php-ext-install gd
RUN docker-php-ext-install exif
RUN docker-php-ext-install fileinfo
RUN docker-php-ext-install gettext
RUN docker-php-ext-install iconv
RUN docker-php-ext-install pdo_firebird
RUN docker-php-ext-install pcntl
RUN docker-php-ext-install phar
RUN docker-php-ext-install posix
RUN docker-php-ext-install pspell
RUN docker-php-ext-install shmop
RUN docker-php-ext-install simplexml
RUN docker-php-ext-install snmp
RUN docker-php-ext-install sysvmsg
RUN docker-php-ext-install sysvsem
RUN docker-php-ext-install sysvshm
RUN docker-php-ext-install xml
#RUN docker-php-ext-install xmlrpc
RUN docker-php-ext-install xmlwriter 
#########################################################################

RUN mkdir -p /usr/src/php/ext/imagick; \
    curl -fsSL https://github.com/Imagick/imagick/archive/06116aa24b76edaf6b1693198f79e6c295eda8a9.tar.gz | tar xvz -C "/usr/src/php/ext/imagick" --strip 1; \
    docker-php-ext-install imagick;

# Install PHP extensions
RUN docker-php-ext-install bz2 calendar gettext soap sockets sysvmsg sysvshm opcache zip sysvsem pdo_mysql mbstring exif pcntl bcmath gd mysqli imagick intl

# RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd mysqli imagick

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN apt-get update && \
    apt-get install -y zlib1g-dev libpng-dev libjpeg-dev

RUN docker-php-ext-configure gd --with-freetype --with-jpeg
 
RUN docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-configure gd --with-jpeg && \
    docker-php-ext-install gd

##################################
RUN apt-get update && apt-get install -y libpng-dev 
RUN apt-get install -y \
    libwebp-dev \
    libjpeg62-turbo-dev \
    libpng-dev libxpm-dev \
    libfreetype6-dev
	
RUN docker-php-ext-configure gd      --with-jpeg      --with-freetype

RUN apt-get update && apt-get install -y libpng-dev 
RUN apt-get install -y \
    libwebp-dev \
    libjpeg62-turbo-dev \
    libpng-dev libxpm-dev \
    libfreetype6-dev

RUN apt-get update && apt-get install -y libpng-dev 
RUN apt-get install -y \
    libwebp-dev \
    libjpeg62-turbo-dev \
    libpng-dev libxpm-dev \
    libfreetype6-dev

RUN docker-php-ext-install gd

##################################

# Configure MailHog
RUN apt-get install --no-install-recommends --assume-yes --quiet ca-certificates curl git &&\
    rm -rf /var/lib/apt/lists/*
RUN curl -Lsf 'https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz' | tar -C '/usr/local' -xvzf -
ENV PATH /usr/local/go/bin:$PATH
RUN go get github.com/mailhog/mhsendmail
RUN cp /root/go/bin/mhsendmail /usr/bin/mhsendmail
RUN echo 'sendmail_path = /usr/bin/mhsendmail --smtp-addr mailhog:1025' > /usr/local/etc/php/conf.d/mail.ini

# Install n98-magerun
RUN cd /usr/src && curl -O https://files.magerun.net/n98-magerun2.phar
RUN cd /usr/src && chmod +x ./n98-magerun2.phar && mv n98-magerun2.phar /usr/bin/magerun

# Install Magento-CLI
RUN curl -sS https://accounts.magento.cloud/cli/installer | php
RUN export PATH=$PATH:$HOME/.magento-cloud/bin

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

# Set working directory
WORKDIR /var/www/html


USER $user