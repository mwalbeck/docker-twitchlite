FROM php:8.4.2-fpm-bullseye@sha256:2ba3a470c25d424dfeedb97e6885033e826f854065635fbfaf6ad8048a5d10fa

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
