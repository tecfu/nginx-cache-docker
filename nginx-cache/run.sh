#!/bin/sh
echo RUNNING NGINX_CACHE ON PORT $NGINX_PORT WHICH IS EXPOSED ON PORT $MAPPED_PORT
docker run -d --name nginx-cache-container \
  --mount src="$(pwd)/nginx.conf",target=/etc/nginx/nginx.conf,type=bind \
  -v $HOME/.nginx/longcache/log:/var/log/nginx \
  -v $HOME/.nginx/longcache/cache:/var/cache/nginx \
  -e NGINX_PORT=$NGINX_PORT \
  -p $MAPPED_PORT:$NGINX_PORT \
  tecfu/nginx-cache-image
