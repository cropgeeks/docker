FROM debian:latest

RUN apt-get update && apt-get install -y apache2 vim

RUN apt-get install -y gbrowse gbrowse-data && a2enmod cgi

STOPSIGNAL SIGWINCH

COPY httpd-foreground /usr/local/bin/

EXPOSE 80

CMD ["httpd-foreground"]
