#!/bin/sh -eu

echo "Start nginx with listen port 8680"
mkdir -p /run/nginx
touch /run/nginx/nginx.pid
/usr/sbin/nginx -c /etc/nginx/nginx.conf

/app/aria2/aria2c.sh

echo "Start filebrowser with listen port 8080"
/app/filebrowser -p 8080 -d /appdata/filebrowser.db -r /data -b /files/
