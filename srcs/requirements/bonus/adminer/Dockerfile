FROM alpine:3.22

RUN apk update && apk add --no-cache \
	php \
	php-fpm \
	php-mysqli \
	php-session \
	wget



WORKDIR /var/www/html

RUN wget https://github.com/vrana/adminer/releases/download/v5.4.1/adminer-5.4.1.php -O index.php

RUN sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php*/php-fpm.d/www.conf

CMD ["php-fpm83", "-F"]