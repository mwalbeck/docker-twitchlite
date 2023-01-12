FROM php:8.1.14-fpm-bullseye@sha256:bdac671e3ca663c0e9dc7008f28b3ee8dc2cc5b2d11fcde83d2142ab0369f457

RUN set -ex; \
    \
    groupadd --system foo; \
    useradd --no-log-init --system --gid foo --create-home foo; \
    \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        gosu \
        git \
    ; \
    mkdir -p /usr/share/twitchlite /var/www/twitchlite; \
    git clone --branch helix https://github.com/mwalbeck/twitchlite.git /usr/share/twitchlite; \
    rm -r /usr/share/twitchlite/.git /usr/share/twitchlite/.gitignore;\
    \
    apt-get purge -y --auto-remove git; \
    rm -rf /var/lib/apt/lists/*; \
    \
    mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini";

COPY entrypoint.sh /entrypoint.sh

WORKDIR /var/www/twitchlite

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]
