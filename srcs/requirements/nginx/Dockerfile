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
RUN     addgroup -S -g ${GROUP_ID} nginx \
 &&     adduser -S -G nginx -u ${USER_ID} nginx

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
# adjust directories rights to launch nginx as non root
 &&     chown -R nginx:nginx \
 			/var/www/wordpress \
			/etc/nginx/ \
			/run/nginx \
			/var/run/nginx

# copy the conf file to the container
COPY    conf/nginx.conf /etc/nginx
COPY    conf/www.conf 	/etc/nginx/conf.d

EXPOSE  443

# launch command as non root
USER    nginx

CMD     ["nginx", "-g", "daemon off;"]
