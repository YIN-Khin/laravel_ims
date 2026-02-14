#!/bin/sh
set -e

php artisan storage:link || true
php artisan config:cache
php artisan migrate --force || true

php artisan config:clear || true
php artisan cache:clear || true


# Run migrations
php artisan migrate --force || true

# Cache again
php artisan config:cache || true
php artisan route:cache || true

exec apache2-foreground
