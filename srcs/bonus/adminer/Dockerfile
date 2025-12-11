FROM alpine:3.22

RUN apk update && apk add --no-cache \
	php \
	php-fpm \
	php-mysqli \
	php-session \
	wget

WORKDIR /var/www/html

RUN wget https://github.com/vrana/adminer/releases/download/v5.4.1/adminer-5.4.1.php -O index.php

COPY ./conf/www.conf /etc/php83/php-fpm.d/www.conf

CMD ["php-fpm83", "-F"]