FROM alpine:3.19

RUN apk update && apk add --no-cache glances

EXPOSE 61208

CMD ["glances", "-w"]