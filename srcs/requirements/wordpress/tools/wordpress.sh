#!/bin/sh
set -e

SQL_PASSWORD=$(cat /run/secrets/db_password)
echo "SQL Password: $SQL_PASSWORD"
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_PASSWORD=$(cat /run/secrets/wp_user_password)


while ! mariadb -h mariadb -u $SQL_USER -p$SQL_PASSWORD $SQL_DATABASE &>/dev/null; do
    sleep 3
done


echo "MariaDB is responding, waiting for full startup..."
sleep 10 

if [ ! -f ./wp-config.php ]; then
    
    wp core download --allow-root

    wp config create \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USER \
        --dbpass=$SQL_PASSWORD \
        --dbhost=mariadb:3306 --allow-root

    wp core install \
        --url=$DOMAIN_NAME \
        --title=$WP_TITLE \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL --allow-root

    wp user create \
        $WP_USER \
        $WP_EMAIL \
        --role=author \
        --user_pass=$WP_PASSWORD --allow-root

fi

if ! wp plugin is-installed redis-cache --allow-root; then
    echo "Installing Redis Cache plugin..."
    wp plugin install redis-cache --activate --allow-root
fi

wp plugin update --all --allow-root
wp config set WP_REDIS_HOST redis --allow-root
wp config set WP_REDIS_PORT 6379 --allow-root

wp redis enable --allow-root || true
wp config set WP_DEBUG true --raw --allow-root

echo "➡️ Redis is ready..."
echo "➡️ WordPress is running..."

chown -R nobody:nobody /var/www/html
exec php-fpm83 -F