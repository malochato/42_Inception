# 🗺️ Roadmap Complète

## 1. Construis ton infrastructure brique par brique

### Étape 1 : L'environnement et l'initialisation
- **Objectif** : Préparer le terrain sur ta VM.
- **Technique** : Installation de Docker, Docker Compose, Make, et création de l'arborescence des dossiers.
- **Point clé** : Le sujet impose des dossiers spécifiques pour les volumes (ex: `/home/login/data/wordpress`). Assure-toi que ton Makefile ou ton script de setup les crée automatiquement s'ils n'existent pas.

### Étape 2 : Le conteneur NGINX (Le Gardien)
- **Objectif** : Un conteneur qui tourne, écoute sur le port 443, et sert une page HTML statique de test avec TLS (SSL).
- **Pourquoi commencer par lui ?** : C'est ton point d'entrée. Si lui ne marche pas, rien n'est accessible.
- **Difficulté** : Générer le certificat SSL auto-signé et configurer NGINX pour l'utiliser.

### Étape 3 : Le conteneur MariaDB (La Mémoire)
- **Objectif** : Une base de données qui s'initialise proprement au démarrage.
- **Difficulté majeure** : MariaDB doit créer la base de données, l'utilisateur et le mot de passe spécifiés dans tes variables d'environnement au premier lancement. Un script d'entrée (entrypoint) sera nécessaire.
- **Test** : Tu dois pouvoir te connecter à la DB depuis un autre conteneur (pas depuis l'hôte directement, sauf pour debug).

### Étape 4 : Le conteneur WordPress (L'Application)
- **Objectif** : Installer et configurer WordPress + PHP-FPM.
- **Piège** : NGINX ne gère pas le PHP. C'est ce conteneur qui va exécuter le code PHP.
- **Configuration** : WordPress doit être configuré pour parler à MariaDB (host, user, pass). Un script pour l'installation automatique (via WP-CLI ou script PHP) sera nécessaire.

### Étape 5 : L'Orchestration (Le Chef d'Orchestre)
- **Objectif** : Relier le tout avec `docker-compose.yml`.
- **Réseau** : Créer un réseau Docker interne pour que les conteneurs se voient par leur nom (ex: `wordpress` peut pinger `mariadb`).
- **Volumes** : Mapper les dossiers de l'hôte vers les conteneurs pour la persistance.

---

## 🧠 Notions Essentielles à Maîtriser

### A. Docker : Image vs Conteneur
- **Image** : Le moule (fichier binaire, libs, OS de base). Statique (lecture seule).
- **Conteneur** : Une instance vivante de l'image avec une couche d'écriture temporaire.
- **Dockerfile** : La recette pour créer l'image.

### B. PID 1 et le "Foreground"
- Un conteneur Docker ne vit que tant que sa commande principale (PID 1) est active.
- **Règle d'or** : Toujours lancer les services en premier plan (`daemon off;` pour NGINX, `console` pour MariaDB, `-F` pour PHP-FPM).

### C. Isolation et Réseaux
- Par défaut, les conteneurs sont isolés.
- Dans `docker-compose`, un réseau virtuel est créé.
- **DNS interne** : Docker intègre un serveur DNS. Si ton service s'appelle `mariadb` dans le `docker-compose`, l'adresse IP de la base de données pour WordPress sera simplement `mariadb`.

### D. Volumes (Bind Mounts)
- Le sujet demande de stocker les données sur l'hôte (`/home/login/data/...`).
- **Bind Mount** : Tu "montes" un dossier réel de ta VM à l'intérieur du conteneur.
- Si tu supprimes le conteneur, les données restent sur ta VM.

---

## 🎓 Explications Pédagogiques : L'Architecture

### Pourquoi cette séparation ?
1. **NGINX** : 
	- Reçoit la requête HTTPS et décrypte le SSL.
	- Sert les fichiers statiques (images, HTML) ou passe les fichiers PHP au conteneur WordPress via FastCGI (port 9000).
2. **WordPress (PHP-FPM)** :
	- Reçoit les demandes de NGINX, exécute le code PHP.
	- Interroge MariaDB pour les données nécessaires (articles, utilisateurs).
3. **MariaDB** :
	- Renvoie les données brutes à WordPress.

C'est une chaîne de responsabilité.

---

## 🛠️ Conseils de Workflow

### Organisation des fichiers
Structure proprement, ne mets pas tout à la racine.

### La méthode "Pas à pas" pour debugger
1. Écris le `Dockerfile` de NGINX.
2. Build l'image : `docker build -t mon-nginx .`
3. Lance le conteneur manuellement : `docker run -it -p 443:443 mon-nginx`
4. Regarde les logs. Si ça plante, corrige.
5. Une fois que ça marche, passe au service suivant.

### Comment entrer dans un conteneur
Si un conteneur tourne mais ne fait pas ce que tu veux, explore-le :
```bash
docker exec -it <nom_du_conteneur> sh
```
- **Vérifie** :
  - Les fichiers sont-ils là ? (`ls -la`)
  - Les permissions sont-elles bonnes ?
  - Peux-tu pinger l'autre conteneur ? (`ping mariadb`)

---

## 📚 Ressources d'apprentissage
Voici les termes à rechercher et lire :
- **Docker** : "Dockerfile reference", "Docker multi-stage build" (optionnel mais propre), "Docker Entrypoint vs CMD".
- **NGINX** : "NGINX reverse proxy configuration", "NGINX fastcgi_pass php-fpm".
- **MariaDB** : "MariaDB initialization script", "mysqld_safe".
- **WordPress** : "WP-CLI install" (très utile pour automatiser l'installation sans cliquer dans le navigateur).
- **Processus** : "Linux PID 1 zombie reaping".

---

Prêt à commencer ? La première étape logique est de créer ton Makefile et ton arborescence, puis de t'attaquer au Dockerfile de NGINX.