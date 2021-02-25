# Nginx Caching Proxy Docker Container

A [Docker](docker) image with [Nginx](nginx) configured to act as a long caching proxy for HTTP requests.

## Inside the image

- [Alpine Linux][alpinelinux] - a lightweight Linux distribution
- [Nginx][nginx] - a web caching proxy

## Sample usage

- Build the container
```
docker build -t tecfu/nginx-cache-image -f Dockerfile .
```

- Set your env variables
```
NGINX_CACHE_PORT=3030
```

- Start the container
```
export CACHE_EXPIRATION="1y"
export MAX_CACHE_SIZE="12g"
export PROXY_PASS_ADDRESS="http://172.17.0.3:3030"
export NGINX_PORT=3031
export MAPPED_PORT=3031
./run.sh
```

Setup system wide network proxy for HTTP ([Example for Ubuntu](https://help.ubuntu.com/stable/ubuntu-help/net-proxy.html))

## Test case

1. Start the container
2. Send twice the same HTTP request through the caching proxy.
```
curl -I -x 'localhost:3030' 'http://cdnjs.cloudflare.com/ajax/libs/react/15.3.1/react.min.js'
```
Second request should be cached and should contain following headers:
```
X-Cached: HIT
X-Cache-Server: tecfu/nginx-cache
```

## NOTES:

To get the local IP address of all docker containers: 
```
for s in `docker ps -q`; do echo ip of `docker inspect -f "{{.Name}}" $s` is `docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $s`; done
```



[alpinelinux]: https://www.alpinelinux.org/
[apache]: https://httpd.apache.org/
[docker]: https://www.docker.com/
[nginx]: https://www.nginx.com/
