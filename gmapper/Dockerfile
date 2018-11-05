FROM centos/httpd

RUN yum install perl perl-CGI perl-DBI perl-DBD-mysql perl-GD wget bzip2 -y

RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh
RUN sh /tmp/miniconda.sh -b -p /conda/ -f
RUN /conda/bin/conda config --add channels R && \
    /conda/bin/conda config --add channels conda-forge && \
    /conda/bin/conda config --add channels bioconda
RUN /conda/bin/conda install gmap blast -y
