FROM cropgeeks/httpd-with-perl

RUN yum install -y perl-GD cairo-devel

RUN yum install -y bzip2 && \
	curl -o /tmp/miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    sh /tmp/miniconda.sh -b -p /conda/ -f && \
    /conda/bin/conda config --add channels R && \
    /conda/bin/conda config --add channels conda-forge && \
    /conda/bin/conda config --add channels bioconda && \
    /conda/bin/conda install r blast -y && \
	echo "export PATH=/conda/bin/:\$PATH" >> /etc/sysconfig/httpd

RUN yum install -y glibc.i686