FROM httpd:2.4

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        perl \
        libcgi-pm-perl \
        libdbi-perl \
        libdbd-mysql-perl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
