FROM rockylinux:10

# System dependencies
RUN dnf -y update && \
    dnf -y install \
        dnf-plugins-core \
        epel-release && \
    dnf config-manager --set-enabled crb && \
    dnf -y install \
        httpd \
        perl \
        perl-CGI \
        perl-DBI \
        perl-DBD-MySQL \
        perl-GD && \
    dnf clean all && \
    rm -rf /var/cache/dnf

# Obtain the standalone micromamba executable
COPY --from=mambaorg/micromamba:2.10.0 \
    /bin/micromamba /usr/local/bin/micromamba

ENV MAMBA_ROOT_PREFIX=/opt/conda

# Install scientific software
COPY environment.yml /tmp/environment.yml

RUN micromamba create -y \
    -p /opt/conda/envs/r \
    -f /tmp/environment.yml && \
    micromamba clean --all --yes

# Make R, BLAST etc available to Apache and Perl
ENV PATH="/opt/conda/envs/r/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin"

# Final Apache setup
RUN echo "ServerTokens Prod" >> /etc/httpd/conf/httpd.conf
RUN echo "ServerSignature Off" >> /etc/httpd/conf/httpd.conf
EXPOSE 80

CMD ["/usr/sbin/httpd", "-DFOREGROUND"]
