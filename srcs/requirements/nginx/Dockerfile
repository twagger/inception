FROM alpine:3.15

RUN     adduser -D -g 'www' www && \
        apk update && \
        apk upgrade  && \
	    apk add --update openssl nginx && \
        mkdir /etc/nginx/certificates && \
	    openssl req \
		    -x509 \
		    -newkey rsa:2048 \
		    -keyout /etc/nginx/certificates/key.pem \
		    -out /etc/nginx/certificates/cert.pem \
		    -days 365 \
		    -nodes \
		    -subj /CN=localhost && \
        mkdir /www && \
        chown -R www:www /www && \
        rm -rf /var/cache/apk/*

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]