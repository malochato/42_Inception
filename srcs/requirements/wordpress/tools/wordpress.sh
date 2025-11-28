#!/bin/sh

SQL_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)


# 1. Attente de la base de données (optionnel mais robuste)
# On essaie de se connecter à MariaDB tant que ça ne marche pas
while ! mariadb -h mariadb -u $SQL_USER -p$SQL_PASSWORD $SQL_DATABASE &>/dev/null; do
    sleep 3
done

# 2. Installation de WordPress
# On vérifie si wp-config.php existe pour ne pas réinstaller à chaque redémarrage
if [ ! -f ./wp-config.php ]; then
    
    # Télécharger WordPress
    wp core download --allow-root

    # Créer le fichier de config (lien avec la DB)
    wp config create \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USER \
        --dbpass=$SQL_PASSWORD \
        --dbhost=mariadb:3306 --allow-root

    # Lancer l'installation (Création des tables + Compte Admin)
    # ATTENTION : --admin_user ne doit pas contenir "admin" !
    wp core install \
        --url=$DOMAIN_NAME \
        --title=$WP_TITLE \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL --allow-root

    # Créer un utilisateur supplémentaire (demandé par le sujet)
    wp user create \
        $WP_USER \
        $WP_EMAIL \
        --role=author \
        --user_pass=$WP_PASSWORD --allow-root
fi

# 3. Lancer PHP-FPM en premier plan
# Le sujet demande que le conteneur ne s'arrête pas.
echo "➡️ WordPress is running..."
exec php-fpm83 -F