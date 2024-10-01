FROM php:8.3-fpm

# Arguments defined in docker-compose.yml
ARG user
ARG uid

# Set working directory
WORKDIR /var/www/api

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential libzip-dev libpng-dev libonig-dev libxml2-dev libjpeg62-turbo-dev libfreetype6-dev \
    locales zip unzip jpegoptim optipng pngquant gifsicle vim git curl wget

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl bcmath gd
RUN docker-php-ext-configure gd --with-freetype --with-jpeg

## Install composer ---------------------------------------------------------
# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create system user to run Composer
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && chown -R $user:$user /home/$user
## Install composer ---------------------------------------------------------

# Install Symfony CLI
RUN curl -sS https://get.symfony.com/cli/installer | bash

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
