FROM cropgeeks/tomcat:9-jre11

RUN apt-get update
RUN apt-get install -y r-base

COPY flapjack-services-20170726.war /usr/local/tomcat/webapps/