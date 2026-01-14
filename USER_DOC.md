# User Documentation

## Overview

- **Services provided:**
    - NGINX — public entrypoint on TCP/443
    - WordPress (PHP-FPM) — runs in a dedicated container
    - MariaDB — dedicated database container
    - Adminer — database administration UI
    - FTP server — file access to the WordPress website files
    - Redis — caching for WordPress
    - Glances — system monitoring

- **Persistence:** Two volumes store the WordPress site files and the MariaDB data. These volumes are exposed on the host under `/home/malde-ch/data`.

- **Network:** All containers are connected through a Docker network defined in `srcs/docker-compose.yml`.

## Start the project

1. Start project with:

     - Run `make`

3. Wait a couple of minutes and then you can acess the services. 

## Stop the project

- Stop and remove containers (preserves volumes):

        `make down`

- Stop, remove containers and anonymous volumes, and prune unused images/networks:

        `make clean`

- Destructively remove containers, prune, and delete persistent volumes:

        `make fclean`

## Accessing the website and administration panel

- Website : https://malde-ch.42.fr  
- WordPress admin panel: https://malde-ch.42.fr/wp-admin or /wp-login

## Accessing Adminer, FTP, Glances and Redis

- Adminer: https://malde-ch.42.fr/adminer
- FTP: standard FTP port 21  
- Glances: https://malde-ch.42.fr/glances  
- Redis: not expose, can be access in the admin pannel, in the section plugin

## Locating and managing credentials

- Locations for credentials:
    - `srcs/.env` — environment variables used by the stack:

        TEMPLATES:

                DOMAIN_NAME
                SQL_USER
                SQL_DATABASE
                WP_TITLE
                WP_ADMIN_USER
                WP_ADMIN_EMAIL
                WP_USER
                WP_EMAIL
                FTP_USER

    - `secrets/` — repository-local secret files:

                secrets/db_password.txt
                secrets/db_root_password.txt
                secrets/wp_admin_password.txt
                secrets/wp_user_password.txt
                secrets/ftp_password.txt

    - Docker secrets: list with `docker secret ls`

## Checking that services are running

- Running containers: `docker ps`  
- Volumes: `docker volume ls`  
- Inspect container state: `docker inspect <container>`.

or if a container is not working you can check the logs by launching it with:
- `docker-compose logs -f <service>`.