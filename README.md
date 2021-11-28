# docker-twitchlite

[![Build Status](https://build.walbeck.it/api/badges/mwalbeck/docker-twitchlite/status.svg)](https://build.walbeck.it/mwalbeck/docker-twitchlite)
![Docker Pulls](https://img.shields.io/docker/pulls/mwalbeck/twitchlite)

Docker container for [twitchLite](https://github.com/mwalbeck/twitchlite). For more information about twitchLite please checkout the project page.

You can find the image on [Docker Hub](https://hub.docker.com/r/mwalbeck/twitchlite) and the source code can be found [here](https://git.walbeck.it/mwalbeck/docker-twitchlite) with a mirror on [github](https://github.com/mwalbeck/docker-twitchlite).

The old version using the kraken api can be found under the kraken tag. The docker container will be updated until the kraken api is shutdown.

## Usage

This is an php-fpm based image, which means it only runs an php-fpm process, and a separate webserver is needed to access twitchLite.

### Configuration

The docker container is intended to be configure through ENV variables, and you have the following options:

| ENV VAR               | default | allowed       | description                                                                         |
| --------------------- | ------- | ------------- | ----------------------------------------------------------------------------------- |
| UID                   | 1000    | Any UID       | The user id the container runs as                                                   |
| GID                   | 1000    | Any GID       | The group id the container runs as                                                  |
| OAUTH_TOKEN           | -       | -             | Your twitch oauth token                                                             |
| USER_ID               | -       | -             | Your twitch user id                                                                 |
| ONLY_FOLLOWED_DEFAULT | false   | true or false | If only channels you follow should be shown by default                              |
| DEFAULT_LIMIT         | 25      | 1-100         | How many livestreams to show at once                                                |
| GET_TOP_GAMES         | true    | true or false | If a list of the currently most played games should be retrieved for autocompletion |
| TOP_GAMES_LIMIT       | 100     | 1-100         | How many of the currently most played games should be retrieved                     |

### Webserver

Since this is only a php-fpm container, you also need a webserver to serve the site. With that you need a shared volume between the 2 containers mounted at ```/var/www/twitchlite```. You can have a look at the docker-compose file below for an example.

This is a pretty basic PHP site, so a basic nginx php-fpm config will work. Though I will note that access should only be given to index.php, and you can safely deny access to all other php files, especially the config.php file, which will contain your twitch oauth token, if you provide one.

### Docker-compose example

Here is an example docker-compose file you can use to setup twitchLite

```
version: '2'

volumes:
  twitchlite:

networks:
  frontend:

services:
  twitchlite:
    image: mwalbeck/twitchlite
    restart: on-failure:5
    networks:
      - frontend
    volumes:
      - twitchlite:/var/www/twitchlite
    environment:
      UID: "1000"
      GID: "1000"
      OAUTH_TOKEN: "YOUR-OAUTH-TOKEN-HERE"
      USER_ID: "YOUR-USER-ID-HERE"
      ONLY_FOLLOWED_DEFAULT: "false"
      DEFAULT_LIMIT: "25"
      GET_TOP_GAMES: "true"
      TOP_GAMES_LIMIT: "100"

  nginx:
    image: nginx
    restart: on-failure:5
    networks:
      - frontend
    volumes:
      - "twitchlite:/var/www/twitchlite:ro"
    ports:
      - "443:443"
      - "80:80"
```
