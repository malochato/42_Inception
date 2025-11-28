#!/bin/sh
set -e

SQL_PASSWORD=$(cat /run/secrets/db_password)
SQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

DB_DIR="/var/lib/mysql"
MYSQL_SYSTEM_DIR="$DB_DIR/mysql"

echo "➡️ Checking for the existence of the MariaDB system database:"

if [ ! -d "$MYSQL_SYSTEM_DIR" ]; then
	echo "➡️ System database does not exists, initializing the MariaDB database..."

	mariadb-install-db --user=mysql --datadir="$DB_DIR"

	mysqld --user=mysql --datadir="$DB_DIR" --skip-networking & MYSQL_PID=$!

	while ! mysqladmin ping --silent; do
		sleep 1
	done

	mariadb <<EOF
-- Set the root password
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';

-- Create the database if it does not exist
CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;

-- Create the user
CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';

-- Grant privileges
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%';

FLUSH PRIVILEGES;
EOF

	mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown
	echo "➡️ Configuration completed."

else
	echo "➡️ System database already exists, initialization skipped."
fi

echo "➡️ Starting MariaDB..."
exec mysqld --user=mysql --console
