FROM cropgeeks/httpd-with-perl

RUN yum update -y && \
        yum install -y epel-release && \
        yum groupinstall -y "Development Tools" && \
        yum install -y sudo perl-GD inkscape glibc.i686 R

RUN yum install -y bzip2 && \
        curl -o /tmp/miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
        sh /tmp/miniconda.sh -b -p /conda/ -f && \
        /conda/bin/conda config --add channels R && \
        /conda/bin/conda config --add channels conda-forge && \
        /conda/bin/conda config --add channels bioconda && \
        /conda/bin/conda install blast -y && \
        echo "export PATH=/conda/bin/:\$PATH" >> /etc/sysconfig/httpd

RUN /usr/bin/R -e "install.packages('LinkageMapView',dependencies=TRUE,repos='http://cran.rstudio.com/')"

RUN echo "apache        ALL=(ALL)       NOPASSWD: /usr/bin/R" >> /etc/sudoers
