FROM cropgeeks/httpd-with-perl:rocky8

RUN yum install -y epel-release

RUN yum update -y && \
		yum install -y --enablerepo=powertools R perl-GD cairo-devel glibc.i686 ImageMagick && \
		yum clean all
