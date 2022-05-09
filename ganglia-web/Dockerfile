FROM rockylinux:8

RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install httpd && \
    yum clean all

RUN yum install -y epel-release
RUN yum install -y ganglia-web

ADD ganglia.conf /etc/httpd/conf.d/ganglia.conf
ADD logo.jpg /usr/share/ganglia/templates/default/images/logo.jpg

ADD run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh
