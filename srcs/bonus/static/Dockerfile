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
WORKDIR /var/www/me

# install nginx and hugo and shadow (login and pass utilities) 
RUN     apk update && apk upgrade && apk add --update --no-cache \
            nginx \
            hugo \
            shadow \
 &&     rm -f /var/cache/apk/* \
\
# create subdir for server confs
 &&		mkdir -p /etc/nginx/conf.d \
\
# create the user and group and directory for pages on the container
 &&     useradd www-data -g www-data \
 &&     usermod -u ${USER_ID} www-data \
 &&     groupmod -g ${GROUP_ID} www-data \
\
# create new hugo site
 &&     hugo new site /var/www/me \
 &&
# adjust directories rights
 &&     chown -R www-data:www-data /var/www/me /etc/nginx/conf.d \
\
# correct rights for user that will launch the CMD
 &&     chown -R nginx /var/lib/nginx \
 &&     chown -R nginx /etc/nginx

# copy the conf file to the container
COPY    conf/nginx.conf /etc/nginx
COPY    conf/wordpress.conf /etc/nginx/conf.d

EXPOSE  80

# launch command as root : nginx will then use www-data
USER    root

CMD     ["nginx", "-g", "daemon off;"]
