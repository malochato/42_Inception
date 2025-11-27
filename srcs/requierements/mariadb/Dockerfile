FROM alpine:3.22

RUN apk update && apk add --no-cache mariadb mariadb-client


#Create a dir, and transfer the ownership to mysql
#Needed for the socket 
RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /run/mysqld

COPY conf/my.cnf /etc/my.cnf.d/mariadb-server.cnf

COPY tools/mariadb.sh /usr/local/bin/mariadb.sh
RUN chmod +x /usr/local/bin/mariadb.sh

ENTRYPOINT [ "sh", "/usr/local/bin/mariadb.sh" ]
