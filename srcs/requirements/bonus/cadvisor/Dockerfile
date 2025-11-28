FROM alpine:3.22

RUN apk update && apk add --no-cache wget

RUN wget https://github.com/google/cadvisor/releases/download/v0.49.1/cadvisor-v0.49.1-linux-amd64 -O /usr/bin/cadvisor

RUN chmod +x /usr/bin/cadvisor

EXPOSE 8080

CMD ["/usr/bin/cadvisor", "-logtostderr"]