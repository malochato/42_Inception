# Developer Documentation

**Prerequisites:**
- Install `docker`, `docker-compose` (or Docker Desktop) and `make`.
- Create a `secrets/` with the necessary files.
- Edit `srcs/.env` with the all the variables.

    (check the USER_DOC.md to see a template for the secrets files, and .env)

**Build & launch:**
- Run `make`

    or
- Run `cd srcs && docker-compose up -d --build`

**Manage containers:**
- Stop: `cd srcs && docker-compose down`
- Stop + volumes: `cd srcs && docker-compose down -v`
- Rebuild single service: `cd srcs && docker-compose up -d --no-deps --build <service>`
    (for the make commands checks USER_DOCS.md)
- Logs: `cd srcs && docker-compose logs -f <service>`
- Exec shell: `cd srcs && docker-compose exec <service> sh`

**Data & persistence:**
- WordPress files volume: `wordpress_data` → host bind `/home/malde-ch/data/wordpress`
- MariaDB data volume: `mariadb_data` → host bind `/home/malde-ch/data/mariadb`
- List volumes: `docker volume ls`
- Inspect mountpoint: `docker inspect <volume> --format '{{ .Mountpoint }}'`
