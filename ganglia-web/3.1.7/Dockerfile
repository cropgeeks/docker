FROM centos:6

RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install httpd && \
    yum clean all

EXPOSE 80

RUN yum install -y https://github.com/cropgeeks/docker/raw/master/ganglia-web/3.1.7/ganglia-3.1.7-3.el6.rf.x86_64.rpm https://github.com/cropgeeks/docker/raw/master/ganglia-web/3.1.7/ganglia-gmetad-3.1.7-3.el6.rf.x86_64.rpm https://github.com/cropgeeks/docker/raw/master/ganglia-web/3.1.7/ganglia-web-3.1.7-3.el6.rf.x86_64.rpm https://github.com/cropgeeks/docker/raw/master/ganglia-web/3.1.7/libconfuse-2.6-2.el6.rf.x86_64.rpm

ADD ganglia.conf /etc/httpd/conf.d/ganglia.conf
ADD logo.jpg /usr/share/ganglia/templates/default/images/logo.jpg

RUN rm /etc/localtime && ln -s /usr/share/zoneinfo/Europe/London /etc/localtime

ADD run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

CMD ["/run-httpd.sh"]
