#!/bin/sh
set -eu

COMPOSE_FILE=srcs/docker-compose.yml
ENV_FILE=srcs/.env

if [ ! -f "$COMPOSE_FILE" ]; then
  echo "ERROR: $COMPOSE_FILE not found"
  exit 2
fi

DOMAIN_NAME="malde-ch.42.fr"
if [ -f "$ENV_FILE" ]; then
  DOMAIN_NAME=$(grep -E '^DOMAIN_NAME=' "$ENV_FILE" | cut -d= -f2- || echo "$DOMAIN_NAME")
fi

services="mariadb redis wordpress adminer website nginx ftp glances"
fail=0

echo "Using domain: $DOMAIN_NAME"

echo "\nChecking containers..."
for s in $services; do
  id=$(docker-compose -f "$COMPOSE_FILE" ps -q $s 2>/dev/null || true)
  if [ -z "$id" ]; then
    echo "❌ $s: container not found"
    fail=1
    continue
  fi
  running=$(docker inspect -f '{{.State.Running}}' $id 2>/dev/null || echo false)
  if [ "$running" = "true" ]; then
    echo "✅ $s: running (id $id)"
  else
    echo "❌ $s: not running"
    fail=1
  fi
done

echo "\nChecking HTTP(S) endpoints via nginx..."
check_url() {
  url=$1; name=$2
  code=$(curl -k -s -o /dev/null -w "%{http_code}" "$url" || echo 000)
  case "$code" in
    200|301|302|403)
      echo "✅ $name: $url ($code)" ;;
    *)
      echo "❌ $name: $url ($code)"; fail=1 ;;
  esac
}

check_url "https://$DOMAIN_NAME/" "nginx (root)"
check_url "https://$DOMAIN_NAME/wp-admin" "WordPress admin"
check_url "https://$DOMAIN_NAME/adminer" "Adminer (via nginx)"
check_url "https://$DOMAIN_NAME/website/" "Website (proxy)"
check_url "https://$DOMAIN_NAME/glances/" "Glances (proxy)"

echo "\nChecking Redis (PING)..."
if docker-compose -f "$COMPOSE_FILE" ps -q redis >/dev/null 2>&1; then
  if docker exec redis redis-cli ping >/dev/null 2>&1; then
    echo "✅ redis: PONG"
  else
    echo "❌ redis: no PONG (redis-cli may be missing or redis down)"
    fail=1
  fi
else
  echo "❌ redis: container not found"
  fail=1
fi

echo "\nChecking FTP published port..."
ftp_hostport=$(docker-compose -f "$COMPOSE_FILE" port ftp 21 2>/dev/null || true)
if [ -n "$ftp_hostport" ]; then
  echo "✅ ftp published at $ftp_hostport"
else
  echo "❌ ftp: port 21 not published"
  fail=1
fi

echo "\nSummary:"
if [ "$fail" -eq 0 ]; then
  echo "All checks passed ✅"
  exit 0
else
  echo "Some checks failed ❌"
  exit 1
fi
