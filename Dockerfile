# Usar uma imagem oficial do PHP 5.6
FROM php:5.6-fpm

# Atualizar os reposit?rios para os arquivos antigos e remover refer?ncias a stretch-updates
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list && \
    sed -i 's|deb http://security.debian.org|#deb http://security.debian.org|g' /etc/apt/sources.list && \
    sed -i '/stretch-updates/d' /etc/apt/sources.list && \
    echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99archive

# Instalar depend?ncias do sistema e extens?es necess?rias
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    default-libmysqlclient-dev \
    zlib1g-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd mbstring pdo pdo_mysql mysql xml zip

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Definir diret?rio de trabalho
WORKDIR /var/www/html

# Conceder permiss?es ? pasta de trabalho
RUN chown -R www-data:www-data /var/www/html

# Expor a porta que o PHP-FPM vai rodar
EXPOSE 9000
