FROM centos/httpd

RUN yum update -y && \
	yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
	yum-config-manager --enable remi-php72 && \
	yum install -y php php-xml php-mysql php-gd php-mbstring && \
	yum clean all
