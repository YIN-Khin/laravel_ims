#!/bin/sh
set -e

echo "Running Laravel migrations..."
php artisan migrate --force || true

exec "$@"
