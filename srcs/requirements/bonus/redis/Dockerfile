FROM alpine:3.22

RUN apk update && apk add --no-cache redis

# Configuration de Redis
# 1. Commenter la ligne 'bind 127.0.0.1' pour écouter sur toutes les interfaces
# 2. Désactiver le mode protégé (car on est dans un réseau Docker sécurisé)
RUN sed -i "s|bind 127.0.0.1|#bind 127.0.0.1|g" /etc/redis.conf && \
    sed -i "s|protected-mode yes|protected-mode no|g" /etc/redis.conf && \
    sed -i "s|# maxmemory <bytes>|maxmemory 256mb|g" /etc/redis.conf && \
    sed -i "s|# maxmemory-policy noeviction|maxmemory-policy allkeys-lru|g" /etc/redis.conf

EXPOSE 6379

CMD ["redis-server", "/etc/redis.conf"]