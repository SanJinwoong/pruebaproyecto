#!/bin/sh

# 1. Salir inmediatamente si un comando falla
set -e

# 2. Compilar assets de frontend con Vite
echo "Building frontend assets..."
npm run build

# 3. Ejecutar las tareas de optimización y migración de Laravel
echo "Running production tasks..."
php artisan config:cache
php artisan route:cache
php artisan view:cache
php artisan migrate --force

# 4. Ejecutar el comando de inicio original de Dokploy/Nixpacks
echo "Starting the web server (Nginx + PHP-FPM)..."
exec node /assets/scripts/prestart.mjs /assets/nginx.template.conf /nginx.conf && (php-fpm -y /assets/php-fpm.conf & nginx -c /nginx.conf)
