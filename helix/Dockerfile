FROM php:8.2.10-fpm-bullseye@sha256:7d006029c2206ad234377872ae88573c13f2e22e3cb13856da30748b48dc06a5

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
