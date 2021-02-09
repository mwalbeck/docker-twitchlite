FROM php:8.0.2-fpm-buster@sha256:9d1ed21cedd9efa442efb5da7b36c03aabdb6198f89a5afcf9ae80d678a2f2b4

RUN set -ex; \
    \
    groupadd --system foo; \
    useradd --no-log-init --system --gid foo --create-home foo; \
    \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        gosu \
    ; \
    rm -rf /var/lib/apt/lists/*; \
    \
    mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini";

RUN set -ex; \
    \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        git \
    ; \
    mkdir -p /usr/share/twitchlite /var/www/twitchlite; \
    git clone https://github.com/mwalbeck/twitchlite.git /usr/share/twitchlite; \
    rm -r /usr/share/twitchlite/.git /usr/share/twitchlite/.gitignore;\
    \
    apt-get purge -y --auto-remove git; \
    rm -rf /var/lib/apt/lists/*;

COPY entrypoint.sh /entrypoint.sh

WORKDIR /var/www/twitchlite

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]
