#!/bin/bash -xe

mv nginx.conf nginx.conf.template
erb nginx.conf.template > nginx.conf
nginx -c $APP_ROOT/nginx.conf
