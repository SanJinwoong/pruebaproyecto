#!/bin/sh

# Salir inmediatamente si un comando falla
set -e

# Ejecutar migraciones
echo "Running migrations..."
php artisan migrate --force

# Iniciar el servidor web
echo "Starting the web server (Nginx + PHP-FPM)..."
exec node /assets/scripts/prestart.mjs /assets/nginx.template.conf /nginx.conf && (php-fpm -y /assets/php-fpm.conf & nginx -c /nginx.conf)
