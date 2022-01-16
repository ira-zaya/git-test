FROM alpine
RUN apk add openrc
RUN apk add apache2
COPY *.* /var/www/localhost/htdocs/
EXPOSE 80
CMD ["/usr/sbin/httpd", "-DFOREGROUND"]