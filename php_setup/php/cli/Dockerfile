FROM php:8.3-cli

# Set working directory
WORKDIR /var/www/cli

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential libzip-dev libpng-dev libonig-dev libxml2-dev libjpeg62-turbo-dev libfreetype6-dev \
    locales zip unzip jpegoptim optipng pngquant gifsicle vim git curl wget iputils-ping

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl bcmath gd
RUN docker-php-ext-configure gd --with-freetype --with-jpeg

RUN pecl install xdebug

# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install Symfony CLI
RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN export PATH="$HOME/.symfony5/bin:$PATH"
RUN mv /root/.symfony5/bin/symfony /usr/local/bin/symfony
