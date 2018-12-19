FROM centos/httpd

COPY svn.repo /etc/yum.repos.d/svn.repo
RUN yum update -y && yum install -y subversion mod_dav_svn

RUN rm -rf /etc/httpd/conf.d/subversion.conf

# This assumes /svn will be linked in during container setup
RUN ln -s /svn/apache/subversion.conf /etc/httpd/conf.d/subversion.conf
