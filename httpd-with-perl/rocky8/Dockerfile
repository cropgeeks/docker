FROM cropgeeks/httpd:rocky8

RUN yum update -y && \
        yum install -y perl perl-CGI perl-DBD-MySQL && \
        yum clean all
