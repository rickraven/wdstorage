FROM alpine:3.23

RUN apk add --no-cache nginx nginx-mod-http-xslt-filter nginx-mod-http-dav-ext && \
    sed -i 's/nginx:x:100:101:nginx:\/var\/lib\/nginx:\/sbin\/nologin/nginx:x:100:101:nginx:\/var\/lib\/nginx:\/bin\/sh/g' /etc/passwd && \
    mkdir /data && \
    chmod -R 777 /data

USER nginx

COPY favicon.ico /etc/nginx/default/
COPY nginx.conf /etc/nginx/
COPY autoindex.xslt /etc/nginx/

COPY --chmod=755 docker-entrypoint.sh /

CMD ["/docker-entrypoint.sh"]


