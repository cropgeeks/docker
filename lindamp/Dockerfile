FROM rockylinux:10

RUN dnf -y update && \
    dnf -y install \
        dnf-plugins-core \
        epel-release && \
    dnf config-manager --set-enabled crb && \
    dnf -y install \
        httpd \
        perl \
        perl-CGI \
        perl-DBI \
        perl-DBD-MySQL \
        perl-GD && \
    dnf clean all && \
    rm -rf /var/cache/dnf

RUN echo "ServerTokens Prod" >> /etc/httpd/conf/httpd.conf
RUN echo "ServerSignature Off" >> /etc/httpd/conf/httpd.conf

EXPOSE 80 443

CMD ["/usr/sbin/httpd", "-DFOREGROUND"]
