FROM node:8 AS build-env
LABEL AUTHOR=lunnlew<lunnlew@gmail.com>

WORKDIR /opt

RUN apt-get -y update
RUN git clone https://github.com/mayswind/AriaNg.git
RUN cd AriaNg && npm install && npm install gulp -g && gulp clean build

RUN filebrowser_version=v2.0.12 \
  && wget -N https://github.com/filebrowser/filebrowser/releases/download/${filebrowser_version}/linux-amd64-filebrowser.tar.gz \
  && tar -zxvf linux-amd64-filebrowser.tar.gz \
  && rm -rf linux-amd64-filebrowser.tar.gz

FROM alpine:edge
RUN apk update
RUN apk add aria2 nginx

WORKDIR /app

COPY --from=build-env /opt/AriaNg/dist /app/ariang
COPY --from=build-env /opt/filebrowser /app/filebrowser

ENV ARIA2_SSL=false

ADD aria2 /app/aria2
ADD nginx-app.conf /etc/nginx/conf.d/default.conf
ADD start.sh /app/start.sh

VOLUME /data
VOLUME /appdata

EXPOSE 80 6800

CMD ["/app/start.sh"]