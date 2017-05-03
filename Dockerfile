FROM ubuntu:16.04
COPY jenkins-slave /usr/local/bin/jenkins-slave
COPY slave.jar /usr/share/jenkins/slave.jar
RUN apt update && \
    echo "deb [arch=amd64] https://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:openjdk-r/ppa && \
    apt-get update && \
    apt-get install openjdk-8-jdk -y && \
    apt-get install -y lrzsz git unzip vim curl wget maven docker-engine=1.13.0-0~ubuntu-xenial
RUN curl -o /usr/local/docker-compse https://github.com/docker/compose/releases/download/1.11.2/docker-compose-Linux-x86_64 && \
    chmod +x /usr/local/docker-compse
ENV MAVEN_VERSION=3.3.9 \
    MAVEN_HOME=/usr/share/maven \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    LANG=C.UTF-8 \
    TZ=Asia/Shanghai \
    JRE_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/ \
    JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/ 
ENTRYPOINT /usr/local/bin/jenkins-slave
