# INCEPTION

This project was created as part of the 42 curriculum by **malde-ch**.

## Description

The goal of this project is to set up a **LEMP stack** using containerization technology. A LEMP stack is a bundle of software used to host websites, composed of the following elements:

*   **L** → Linux (OS) - *Alpine Linux* in our case.
*   **E** → Nginx (pronounced Engine-X) - *Web Server*.
*   **M** → MariaDB - *Database*.
*   **P** → PHP - *Scripting Language*.

In this project, we also learn about Docker who allows the application and its dependencies to be encapsulated in lightweight, isolated containers based on reusable images.

**Docker Compose** simplifies the definition and launch of multi-container environments via a `docker-compose.yml` file by orchestrating services, networks, volumes, and lifecycle commands (up/down).

*   **Networking:** The default bridge network provides an isolated bridge between containers on the same host, allowing internal communication by service name while controlling port mapping to the host.
*   **Storage:** Docker volumes offer data persistence managed by Docker, storing data outside the container lifecycle. This is safer and more portable than bind mounts, especially for databases.

---

## Instructions

To launch the project, follow these steps:

1.  Create a `.env` file with all required environment variables.
2.  Create a `secrets` directory containing the keys/files necessary for the different containers to operate.
3.  Launch the stack using Make:
    ```bash
    make
    ```

---

## Quick Comparisons

### Virtual Machines vs. Docker
*   **VM:** Complete kernel isolation, heavier, slower startup. Good for strong isolation.
*   **Docker:** Lighter container-based isolation, fast startup. Ideal for microservices and dev/test environments; less kernel-level isolation (potentially less secure).

### Secrets vs. Environment Variables
*   **Secrets:** Encrypted storage and controlled injection. Avoids exposing values in history or logs. Recommended for passwords.
*   **Env Vars:** Convenient for configuration but prone to leaks (process lists, logs, `.env` files). Avoid for critical secrets.

### Docker Network vs. Host Network
*   **Bridge / Overlay:** Default isolation between containers, uses NAT for external access, and controlled port mapping. Overlay allows multi-host communication. Good security/portability compromise.
*   **Host:** The container shares the host's networking stack (no NAT or mapping). Native latency and throughput, useful for performance or low-level network access. Significantly reduces isolation and increases the risk of port conflicts and service exposure.

### Docker Volumes vs. Bind Mounts
*   **Docker Volumes:** Managed by Docker, portable, better for data persistence (DB), managed permissions, simpler backup/restore.
*   **Bind Mounts:** Links a host directory to the container (useful in dev for code reloading). Less portable and carries a potential risk of permission mismatch.

---

## Resources

### Docker
*   [Docker Video Tutorial](https://www.youtube.com/watch?v=pg19Z8LL06w)
*   [Docker Manuals](https://docs.docker.com/manuals/)
*   [Docker Compose Documentation](https://docs.docker.com/compose/)

### Nginx
*   [Install Nginx on Alpine Linux](https://www.cyberciti.biz/faq/how-to-install-nginx-web-server-on-alpine-linux/)

### Wordpress
*   [WP-CLI](https://wp-cli.org/)
*   [Install WordPress with Docker Compose](https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-docker-compose)

### MariaDB
*   [Installing MariaDB via Docker](https://mariadb.com/docs/server/server-management/automated-mariadb-deployment-and-administration/docker-and-mariadb/installing-and-using-mariadb-via-docker)
*   [MariaDB Docker Guide](https://www.ionos.ca/digitalguide/hosting/technical-matters/mariadb-docker/)

---

## AI Usage

For this project, I used AI primarily for two aspects:

*   **Debugging:** AI helped me understand why different services failed to work together. I provided inputs such as container logs and configuration files to identify issues.
*   **Deep Dive:** AI allowed me to deepen my understanding of the various services I was implementing, particularly regarding the bonus services.