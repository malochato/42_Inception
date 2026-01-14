This project has been created as part of the 42 curriculum by malde-ch


Description:
Le but de ce projet est de mettre en place un LEMP stack, en utilisant en plus la technologie des containers. 
A LEMP stack est un facon de host des site web, il est composer par les element suivant:
L --> Linux (OS), dans notre cas Alpine
E --> Nginx, prononcer engine X (Web server).
M --> Maria DB (database)
P --> PHP -fpm (scripting language)



Dans ce projet, la containerisation avec Docker permet d'encapsuler l’application et ses dépendances dans des conteneurs légers et isolés, basés sur des images réutilisables.
Docker Compose facilite la définition et le lancement d’ensembles multi‑conteneurs via un fichier docker‑compose.yml en orchestrant la création des services, des réseaux, des volumes et les commandes de cycle de vie (up/down). 
Le réseau bridge, utilisé par défaut, fournit un pont isolé entre conteneurs sur un même hôte, autorisant la communication interne par nom de service tout en contrôlant le mappage des ports vers l’hôte. 
Enfin, les volumes Docker offrent une persistance des données gérée par Docker, stockant les données hors du cycle de vie d’un conteneur et constituant une solution plus sûre et portable que les bind mounts, notamment pour les bases de données.


Instructions:
Pour lancer le projet, plusieurs etapes doivent etre faites:
- creer le fichier .env avec toutes les varaibles d'environement
- un dossier Secret, avec les fichiers necessaires par les differents containers pour faire fonctionner les services. 
Et enfin pour tout lancer rien de plus simple que simplement faire un Make. 



Comparaisons rapides:
- Virtual Machines vs Docker
    - VM : isolation complète du kernel, plus lourde, démarrage lent, bonne pour isolation forte.
    - Docker : isolation par conteneur plus légère, démarrage rapide, idéal pour microservices et dev/test ; moins d’isolation kernel-level (donc moins de securite notament).

- Secrets vs Environment Variables
    - Secrets : stockage chiffré et injection contrôlée, évitent d’exposer les valeurs dans l’historique ou dans des logs, recommandés pour mots de passe.
    - Env vars : pratiques pour configuration légère, mais faciles à fuir (process list, logs, .env files), à éviter pour secrets critiques.

- Docker Network vs Host Network
    - Bridge / overlay : isolation par défaut entre conteneurs, NAT pour l’accès externe et mappage de ports contrôlé. Overlay permet la communication multi‑hôte (orchestration). Bon compromis sécurité/portabilité, recommandé pour la plupart des déploiements.
    - Host : le conteneur partage la pile réseau de l’hôte (pas de NAT ni de mappage), latence et débit natifs, utile pour besoins de performance ou d’accès bas‑niveau au réseau. Réduit fortement l’isolation, risque de conflits de ports et d’exposition des services.

- Docker Volumes vs Bind Mounts
    - Volumes Docker : gérés par Docker, portables, meilleurs pour persistance de données (BD), permissions gérées, backup/restore plus simple.
    - Bind mounts : lient un répertoire hôte au container (utile en dev pour rechargement de code), moins portable et potentiel risque de mismatch de permissions.
    




Ressources: 

Docker:
    -https://www.youtube.com/watch?v=pg19Z8LL06w
    -https://docs.docker.com/manuals/
    -https://docs.docker.com/compose/

Nginx:
    -https://www.cyberciti.biz/faq/how-to-install-nginx-web-server-on-alpine-linux/

Wordpress:
    -https://wp-cli.org/
    -https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-docker-compose

Maria DB:
    -https://mariadb.com/docs/server/server-management/automated-mariadb-deployment-and-administration/docker-and-mariadb/installing-and-using-mariadb-via-docker
    -https://www.ionos.ca/digitalguide/hosting/technical-matters/mariadb-docker/

    AI:
De plus dans ce projet j'ai utilise l'IA principlaement pour deux aspects: 
    - Le premier du Debug, l'IA m'a permis de comprendre pourquoi les differents services n'arrivaient pas a fonctionner ensemble, pour cela j'ai pu donner les input suivant: les logs des containers, mais aussi les fichier des conf des containers. 
    - Secondement, l'IA m'a permis d'appronfondir les differentes question que j'avais par rraport au differents servieces que je mettais en place, notament dans les services bonus. 