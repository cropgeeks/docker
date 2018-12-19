FROM centos/httpd

RUN yum update -y && \
	yum install -y epel-release && \	
	yum install -y mod_ssl certbot && \
	yum clean all
