#!/usr/bin/env bash

[[ ${DEBUG} == true ]] && set -x

mkdir -p /etc/ssl/localcerts
[ ! -f /etc/ssl/localcerts/default.key ] && openssl req -x509 -nodes -newkey rsa:4096 -keyout /etc/ssl/localcerts/default.key -out /etc/ssl/localcerts/default.crt -subj $SSL_CERT_SUBJ
[ ! -f /etc/ssl/localcerts/dhparam.pem ] && openssl dhparam -out /etc/ssl/localcerts/dhparam.pem 4096

dockerize -template /etc/nginx/nginx.tmpl:/etc/nginx/nginx.conf
exec "$@"