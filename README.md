# wdstorage

A simple and lightweight implementation of [nginx autoindex](https://nginx.org/en/docs/http/ngx_http_autoindex_module.html) with the ability to upload and delete files via a web interface.

The project consists of a pre-configured nginx and launch scripts packaged into a docker image.

**Modern, clean look with breadcrumbs.**

![pic1](https://github.com/EvilVir/Nginx-Autoindex/raw/master/p1.jpg)

**Upload multiple files without any backend, just WebDav & AJAX.**

![pic2](https://github.com/EvilVir/Nginx-Autoindex/raw/master/p2.jpg)

## Deploy as docker image

Simple command:

```
docker run --rm -p 8080:8080 rickraven/wdstorage
```

Then you can visit `http://localhost:8080/` in your browser. 

Example `docker-compose.yml` for `wdstorage`:

```
services:
  wdstorage:
    image: rickraven/wdstorage:1.1
    container_name: wdstorage
    environment:
      - WDSTORAGE_WORKDIR=/data/mydata
    ports:
      - 80:8080
    volumes:
      - wdstorage-data:/data/mydata

volumes:
  wdstorage-data:
```

List of environment variables:

| Parameter | Dafault | Description |
| --- | --- | --- |
| `WDSTORAGE_WORKDIR` | `/data` | Directory to store files |
| `WDSTORAGE_PREFIX` | `/` | Serving http requests on prefix |
| `WDSTORAGE_PORT` | `8080` | Port on which the nginx will be served |

By default, the container runs as the `nginx` user (uid: 100, gid: 101). To upload files, the working directory must be writable by the user. If ports up to 1024 are required, the container must run as the `root` user.

## Credits

Based on [Nginx-Autoindex](https://github.com/EvilVir/Nginx-Autoindex) by [Kuba Pilecki](https://github.com/EvilVir).

