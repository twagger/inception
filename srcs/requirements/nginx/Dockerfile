# syntax=docker/dockerfile:1
FROM    alpine:3.15

# labels
LABEL   org.opencontainers.image.authors=twagner
LABEL   org.opencontainers.image.source=https://github.com/twagger/inception
LABEL   org.opencontainers.image.version=0.1.0 

# install nginx and openssl 
RUN     apk update && apk upgrade && apk add --update --no-cache \
            nginx \
            openssl \
 &&     rm -f /var/cache/apk/* \

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

# create the user and group and directory for pages on the container
 &&     addgroup -g 82 -S www-data ;\
        adduser -u 82 -D -S -G www-data www-data \
 &&     mkdir /var/www/wordpress \
 &&     chown -R www-data:www-data /var/www \

# correct rights for user that will launch the CMD
 &&     chown -R nginx /var/lib/nginx \
 &&     chown -R nginx /etc/nginx

# copy the conf file to the container
COPY    conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE  443

# launch command as non root
#USER    nginx
USER    root

CMD     ["nginx", "-g", "daemon off;"]