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
RUN     addgroup -S -g ${GROUP_ID} cadvisor \
 &&     adduser -S -G cadvisor -u ${USER_ID} cadvisor \
\
# install dependencies needed by cadvisor 
 &&     apk update && apk upgrade && apk add --update --no-cache \
            libc6-compat \
 &&     rm -f /var/cache/apk/* \
\
# create a directory to bind local docker daemon socket
 &&     mkdir -p /var/run/docker \
\
# get cadvisor on a specific folder
 &&     wget -O /usr/local/bin/cadvisor "https://github.com/google/cadvisor/releases/download/v0.45.0/cadvisor-v0.45.0-linux-amd64" \
 &&     chmod +x /usr/local/bin/cadvisor

EXPOSE  8080

# launch command as non root
USER    cadvisor

CMD     ["cadvisor", "-logtostderr"]
