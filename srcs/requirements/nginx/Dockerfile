FROM alpine:3.15

# copy the conf file to the container
COPY conf/nginx.conf /etc/nginx/nginx.conf

# install nginx and openssl 
RUN     apk update && \
        apk upgrade  && \
	    apk add --update openssl nginx

# generate self signed certificate
RUN     mkdir /etc/nginx/certificates && \
	    openssl req \
		    -x509 \
		    -newkey rsa:2048 \
		    -keyout /etc/nginx/certificates/twagner.key \
		    -out /etc/nginx/certificates/twagner.cert \
		    -days 365 \
		    -nodes \
		    -subj /CN=compute-1.amazonaws.com
# create the directory for pages on the container
RUN     mkdir /www

# clean the cache to keep container small
RUN     rm -rf /var/cache/apk/*

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]