FROM php:7.1.33-apache

# Install applications needed
RUN apt update && apt upgrade -y
RUN apt-get install -y nano iputils-ping \
 && apt-get install -y openssl openssh-client libssl-dev \
 && apt-get install -y wget curl git zip \
 && apt-get install -y -qq libzmq3-dev \
 && apt-get install -y libxml2-dev libpng-dev zlib1g-dev libzip-dev \
 && echo "Done apt install"

# install php extentions
RUN pecl install zmq-beta && pecl install apcu && pecl install apcu_bc-1.0.3
RUN docker-php-ext-install mysqli \
 && docker-php-ext-enable mysqli \
 && docker-php-ext-install json \
 && docker-php-ext-install mbstring \
 && docker-php-ext-install pdo \
 && docker-php-ext-install pdo_mysql \
 && docker-php-ext-install dom \
 && docker-php-ext-enable zmq \
 && docker-php-ext-install soap \
 && docker-php-ext-install gd \
 && docker-php-ext-configure zip --with-libzip \
 && docker-php-ext-install zip \
 && docker-php-ext-enable apcu --ini-name 10-docker-php-ext-apcu.ini \
 && docker-php-ext-enable apc --ini-name 20-docker-php-ext-apc.ini \
 && echo "Done docker install"

# nvm environment variables
RUN mkdir -p /usr/local/nvm
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 10.0.0

# install nvm
# https://github.com/creationix/nvm#install-script
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.39.1/install.sh | bash

## add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# move site configs to the container
COPY config/sites-available /etc/apache2/sites-available

# Enable modules needed
RUN a2enmod rewrite.load
# Disable default site
RUN a2dissite 000-default
# Enable sites
RUN a2ensite b-bets 24bettle big5casino luckybull rembrandt sieger gambeta10 tournaverse

# Enable bower packages as root user
RUN echo '{ "allow_root": true }' > /root/.bowerrc
