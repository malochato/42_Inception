FROM alpine:3.22

RUN apk update && apk add --no-cache nginx openssl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/nginx.key \
	-out /etc/nginx/ssl/nginx.crt \
	-subj "/C=ES/ST=Madrid/L=Madrid/O=42/OU=Student/CN=malde-ch.42.fr"

RUN mkdir -p /var/www/html

COPY conf/nginx.conf /etc/nginx/http.d/default.conf

CMD ["nginx" ,"-g" ,"daemon off;"]