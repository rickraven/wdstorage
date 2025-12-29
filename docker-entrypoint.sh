#!/bin/sh

set -e

if [ -z $WDSTORAGE_WORKDIR ]; then WDSTORAGE_WORKDIR=/data; fi
if [ -z $WDSTORAGE_PREFIX ]; then WDSTORAGE_PREFIX=/; fi
if [ -z $WDSTORAGE_PORT ]; then WDSTORAGE_PORT=8080; fi

mkdir -p /tmp/webdav
mkdir -p /tmp/sites-enabled
mkdir -p $WDSTORAGE_WORKDIR

cat <<EOF > /tmp/sites-enabled/wdstorage.conf
# Enable xslt autoindexing and WebDav
server {
    listen $WDSTORAGE_PORT;
    server_name _;

    location $WDSTORAGE_PREFIX {
        alias $WDSTORAGE_WORKDIR/;

        # Enable xslt autoindexing
        autoindex on;
        autoindex_format xml;
        autoindex_exact_size off;
        autoindex_localtime off;
        xslt_stylesheet /etc/nginx/autoindex.xslt;

        # Enable WebDav
        client_body_temp_path /tmp/webdav;
        dav_methods PUT DELETE;
        add_header X-Options "WebDav";
        create_full_put_path on;
        dav_access group:rw all:r;            
    }

    location = /favicon.ico {
        expires 1M;
        add_header 'Access-Control-Allow-Origin' '*';
        access_log off;
        alias /etc/nginx/default/favicon.ico;
    }
}
EOF

nginx -g 'daemon off;'

