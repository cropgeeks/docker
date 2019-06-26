FROM openjdk:8-jdk-stretch

# Download Ant
RUN wget http://apache.mirrors.nublue.co.uk//ant/binaries/apache-ant-1.10.6-bin.tar.gz -P /tmp
# Extract Ant to /opt
RUN tar -zvxf /tmp/apache-ant-1.10.6-bin.tar.gz --directory /opt/
# Clone Germinate
RUN git clone https://github.com/germinateplatform/germinate.git --branch v3.5.0 /opt/germinate
# Copy template properties
RUN cp /opt/germinate/build.template.properties /opt/germinate/build.properties
# Clone Gatekeeper
RUN git clone https://github.com/germinateplatform/germinate-gatekeeper.git --branch v3.5.0 /opt/gatekeeper
# Copy template properties
RUN cp /opt/gatekeeper/build.template.properties /opt/gatekeeper/build.properties

# Install the MySQL client
RUN apt-get update && apt-get install -y mysql-client

# Copy our script into the container
COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

# Run it at startup
ENTRYPOINT ["/docker-entrypoint.sh"]

