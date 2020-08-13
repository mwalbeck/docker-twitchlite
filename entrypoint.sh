#!/bin/sh
set -eu

UID=${UID:-1000}
GID=${GID:-1000}
OAUTH_TOKEN=${OAUTH_TOKEN:-}
ONLY_FOLLOWED_DEFAULT=${ONLY_FOLLOWED_DEFAULT:-false}
DEFAULT_LIMIT=${DEFAULT_LIMIT:-25}
GET_TOP_GAMES=${GET_TOP_GAMES:-false}
TOP_GAMES_LIMIT=${TOP_GAMES_LIMIT:-10}

usermod -o -u "$UID" foo
groupmod -o -g "$GID" foo

rm -rf /var/www/twitchlite/*
cp -r /usr/share/twitchlite/* /var/www/twitchlite/

cat > config.php << EOL
<?php
\$oauth_token = "${OAUTH_TOKEN}";
\$only_followed_default = ${ONLY_FOLLOWED_DEFAULT};
\$default_limit = "${DEFAULT_LIMIT}";
\$get_top_games = ${GET_TOP_GAMES};
\$top_games_limit = "${TOP_GAMES_LIMIT}";
EOL

chown foo /proc/self/fd/1 /proc/self/fd/2
chown -R foo:foo /var/www/twitchlite

exec gosu foo "$@"
