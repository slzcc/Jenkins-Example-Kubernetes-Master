FROM docker:latest AS docker-cli
FROM ubuntu:16.04
COPY jenkins-slave /usr/local/bin/jenkins-slave
COPY slave.jar /usr/share/jenkins/slave.jar
COPY --from=docker-cli /usr/local/bin/docker /usr/local/bin/

RUN apt update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:openjdk-r/ppa && \
    apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y git lrzsz git unzip vim curl wget maven npm nodejs dnsutils net-tools python3 python3-pip && \
    pip3 install jinja2 && \
    rm --force --recursive \
        /tmp/* \
        /var/lib/apt/lists/*

RUN curl -L https://github.com/docker/compose/releases/download/1.24.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    chmod +x /usr/local/docker-compse

ENV MAVEN_VERSION=3.3.9 \
    MAVEN_HOME=/usr/share/maven \
    LANGUAGE=en_US:en \
    LANG=en_US.UTF-8 \
    TZ=Asia/Shanghai \
    JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/ \
    JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/

ENTRYPOINT /usr/local/bin/jenkins-slave
