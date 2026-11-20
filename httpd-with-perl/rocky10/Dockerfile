FROM rockylinux:10

RUN dnf -y update && \
    dnf -y install \
        httpd \
        mod_ssl \
        perl \
        perl-CGI \
        perl-DBI \
        perl-DBD-MySQL && \
    dnf clean all

RUN echo "ServerTokens Prod" >> /etc/httpd/conf/httpd.conf
RUN echo "ServerSignature Off" >> /etc/httpd/conf/httpd.conf

EXPOSE 80 443

CMD ["/usr/sbin/httpd", "-DFOREGROUND"]
