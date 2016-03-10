FROM ubuntu:14.04
MAINTAINER Marlon Silva Carvalho "marlon.carvalho@gmail.com"

RUN apt-get update && apt-get -y install wget

RUN wget http://demoiselle.c3sl.ufpr.br/ComunidadeFrameworkDemoiselle.asc && \
    wget http://demoiselle.c3sl.ufpr.br/public_key.asc

RUN apt-key add ComunidadeFrameworkDemoiselle.asc && \
    apt-key add public_key.asc

RUN echo "deb http://demoiselle.c3sl.ufpr.br universal stable" >> /etc/apt/sources.list && \
    apt-get update && apt-get install -y openjdk-7-jdk demoiselle-jboss-7.1

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

RUN /opt/demoiselle/server/jboss-7.1/bin/add-user.sh --silent=true user pass > /tmp/test.log
CMD ["/opt/demoiselle/server/jboss-7.1/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
