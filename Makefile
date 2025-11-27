NAME = inception
SRCS = ./srcs/docker-compose.yml

LOGIN = $(shell whoami)
VOLUMES_PATH = /home/$(LOGIN)/data

WORDPRESS = /home/$(LOGIN)/data/wordpress
MARIADB = /home/$(LOGIN)/data/mariadb

all: 
	mkdir -p $(WORDPRESS)
	mkdir -p $(MARIADB)
	docker-compose -f $(SRCS) up --build -d


down: 
	docker-compose -f $(SRCS) down

clean: down
	docker system prune -a

fclean: clean
 docker run --rm -v /home/$(LOGIN)/data:/data alpine sh -c "rm -rf /data/*"	

re: fclean all

.PHONY: all down clean fclean re