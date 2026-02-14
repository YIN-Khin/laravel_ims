#!/bin/sh
set -e

# Render sets PORT; default 80
: "${PORT:=80}"

# Laravel cache clear (optional)
php artisan config:clear || true
php artisan cache:clear || true

# Run migrations (do not fail container if DB not ready yet)
php artisan migrate --force || true

# Passport keys + clients (do not fail container if already installed)
php artisan passport:keys --force || true
php artisan passport:client --personal --no-interaction || true
# (optional) if you also need password grant:
# php artisan passport:client --password --no-interaction || true

# Optimize config (optional)
php artisan config:cache || true
php artisan route:cache || true

# Start Apache
exec apache2-foreground
