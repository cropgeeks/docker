FROM cropgeeks/tomcat:8-jre8

RUN apt-get update
RUN apt-get install -y ant git software-properties-common && \
	add-apt-repository ppa:webupd8team/java -y && \
	apt-get update && \
	echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
	apt-get install oracle-java8-installer -y --allow-unauthenticated
