FROM node:carbon

ENV APP_ROOT /app
ENV PORT 8080
ENV NGINX_RESOLVER "8.8.8.8 8.8.4.4 1.1.1.1"
ENV FORCE_HTTPS 1
EXPOSE $PORT

RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup && \
    apt-get update && \
    apt-get install -y nginx ruby && \
    rm -rf /var/lib/apt/lists/*

COPY ./ /tmp
WORKDIR /tmp
RUN npm install grunt -g && \
    npm install && \
    /usr/local/bin/grunt build &&\
    mv /tmp/build $APP_ROOT && \
    rm -rf /tmp

COPY entrypoint.sh /
WORKDIR $APP_ROOT

ENTRYPOINT ["/entrypoint.sh"]
