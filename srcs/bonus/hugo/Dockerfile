# syntax=docker/dockerfile:1
FROM    alpine:3.15

# labels
LABEL   org.opencontainers.image.authors=twagner
LABEL   org.opencontainers.image.source=https://github.com/twagger/inception
LABEL   org.opencontainers.image.version=0.1.0 

# args for proper user rights management
ARG     USER_ID=${USER_ID}
ARG     GROUP_ID=${GROUP_ID}

# workdir
WORKDIR /var/hugo/me

# install nginx and hugo and shadow (login and pass utilities) 
RUN     apk update && apk upgrade && apk add --update --no-cache \
            hugo \
            git \
            shadow \
 &&     rm -f /var/cache/apk/* \
\
# create new hugo site
 &&     hugo new site /var/hugo/me \
 &&     cd /var/hugo/me \
 &&     git clone https://github.com/vaga/hugo-theme-m10c themes/m10c \
 &&     hugo new posts/presentation.md \
 &&     hugo

# copy config and content files
COPY    conf/config.toml        /var/hugo/me/config.toml
COPY    conf/presentation.md    /var/hugo/me/content/posts/presentation.md

EXPOSE  1313

# launch command as root
USER    root

#CMD [ "tail", "-f", "/dev/null" ]
CMD     ["hugo", "server", "--bind=0.0.0.0", "-p", "1313"]
