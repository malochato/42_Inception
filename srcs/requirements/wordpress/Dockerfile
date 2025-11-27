FROM alpine:3.22

RUN apk update && apk add --no-cache \
	php \
	php-fpm \
	php-mysqli \
	php-phar \
	php-curl \
	php-exif \
	php-fileinfo \
	php-mbstring \
	php-openssl \
	php-xml \
	php-zip \
	wget \
	unzip \
	mariadb-client


RUN sed -i 's/memory_limit = 128M/memory_limit = 512M/g' /etc/php*/php.ini

COPY conf/www.conf /etc/php82/php-fpm.d/www.conf
COPY conf/www.conf /etc/php83/php-fpm.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY tools/wordpress.sh /usr/local/bin/wordpress.sh
RUN chmod +x /usr/local/bin/wordpress.sh

WORKDIR /var/www/html

ENTRYPOINT [ "sh", "/usr/local/bin/wordpress.sh" ]