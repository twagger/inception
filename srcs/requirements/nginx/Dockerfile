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

# install nginx and openssl and shadow (login and pass utilities) 
RUN     apk update && apk upgrade && apk add --update --no-cache \
            nginx \
            openssl \
            shadow \
 &&     rm -f /var/cache/apk/* \
\
# generate self signed certificate
 &&     mkdir /etc/nginx/certificates && \
	    openssl req \
		    -x509 \
		    -newkey rsa:2048 \
		    -keyout /etc/nginx/certificates/twagner.key \
		    -days 365 \
		    -out /etc/nginx/certificates/twagner.cert \
		    -nodes \
		    -subj /CN=twagner.42.fr \
\
# create subdir for server confs
 &&		mkdir -p /etc/nginx/conf.d \
\
# create the user and group and directory for pages on the container
 &&     useradd www-data -g www-data \
 &&     usermod -u ${USER_ID} www-data \
 &&     groupmod -g ${GROUP_ID} www-data \
\
# adjust directories rights
 &&     chown -R www-data:www-data /var/www/wordpress /etc/nginx/conf.d

# copy the conf file to the container
COPY    conf/nginx.conf /etc/nginx
COPY    conf/wordpress.conf /etc/nginx/conf.d

EXPOSE  443

# launch command as root : nginx will then use www-data
USER    root

CMD     ["nginx", "-g", "daemon off;"]
