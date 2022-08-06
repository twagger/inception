# syntax=docker/dockerfile:1
FROM    alpine:3.15

# labels
LABEL   org.opencontainers.image.authors=twagner
LABEL   org.opencontainers.image.source=https://github.com/twagger/inception
LABEL   org.opencontainers.image.version=0.1.0

# args for proper user rights management
ARG     USER_ID=${USER_ID}
ARG     GROUP_ID=${GROUP_ID}

# add redis user and group with current host userid and groupid
RUN     addgroup -S -g ${GROUP_ID} redis \
 &&     adduser -S -G redis -u ${USER_ID} redis \
\
# install redis and shadow (login and pass utilities) 
 &&     apk update && apk upgrade && apk add --update --no-cache \
            redis \
            shadow \
 &&     rm -f /var/cache/apk/* \
\
# adapt file authorizations
 &&     chown -R redis:redis /run/redis/ /var/lib/redis

# copy configuration file
COPY    conf/redis.conf   /etc/

EXPOSE  6379

# launch command as non root
USER    redis

CMD     ["redis-server", "/etc/redis.conf"]
