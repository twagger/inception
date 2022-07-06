# syntax=docker/dockerfile:1
FROM    alpine:3.15

# copy the conf file to the container
COPY    conf/nginx.conf /etc/nginx/nginx.conf

# install nginx and openssl 
RUN     apk update && apk upgrade && apk add --update \
            nginx \
            openssl

# generate self signed certificate
RUN     mkdir /etc/nginx/certificates && \
	    openssl req \
		    -x509 \
		    -newkey rsa:2048 \
		    -keyout /etc/nginx/certificates/twagner.key \
		    -days 365 \
		    -out /etc/nginx/certificates/twagner.cert \
		    -nodes \
		    -subj /CN=compute-1.amazonaws.com

# create the directory for pages on the container
RUN     addgroup -g 82 -S www-data ; \
        adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1

RUN     mkdir /www \
 &&     chown -R www-data:www-data /www

# clean the cache to keep container small
RUN     rm -rf /var/cache/apk/*

EXPOSE  443

CMD     ["nginx", "-g", "daemon off;"]