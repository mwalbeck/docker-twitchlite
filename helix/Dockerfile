FROM php:8.2.19-fpm-bullseye@sha256:b1d32b7a08d5f1877b0befa9cc19ed072502035897b638e89a1cbdb34ce5c05f

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
