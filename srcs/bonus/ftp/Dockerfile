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
WORKDIR /var/www/wordpress

# add specific user and group with current host userid and groupid to run the process
RUN     addgroup -S -g ${GROUP_ID} vsftp \
 &&     adduser -S -G vsftp -u ${USER_ID} vsftp \
\
# install vsftp and shadow (login and pass utilities) 
 &&     apk update && apk upgrade && apk add --update --no-cache \
            vsftpd \
            shadow \
 &&     rm -f /var/cache/apk/* \
\
# create and own log file
 &&     touch /var/log/vsftpd.log \
 &&     chown vsftp:vsftp /var/log/vsftpd.log /var/www/wordpress

# copy configuration file
COPY    conf/vsftpd.conf /etc/vsftpd/

# launching user must own the configuration file
RUN     chown -R vsftp:vsftp /etc/vsftpd

EXPOSE  7042

# launch command as non root
USER    vsftp

CMD     ["vsftpd", "/etc/vsftpd/vsftpd.conf"]
