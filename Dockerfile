FROM php:8.1-apache

# Install necessary PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Copy your application code to the container
COPY . /var/www/html/

# Set proper file permissions
RUN chown -R www-data:www-data /var/www/html/ && chmod -R 755 /var/www/html/

# Set Apache's DocumentRoot to /var/www/html/project
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/project|g' /etc/apache2/sites-available/000-default.conf

# Also update <Directory> path in Apache config to allow access
RUN sed -i 's|<Directory /var/www/>|<Directory /var/www/html/project/>|g' /etc/apache2/apache2.conf

# Allow .htaccess overrides
RUN sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf

WORKDIR /var/www/html/project
