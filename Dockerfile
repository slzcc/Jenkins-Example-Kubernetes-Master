FROM python:3
COPY jenkins-slave /usr/local/bin/jenkins-slave
COPY slave.jar /usr/share/jenkins/slave.jar
COPY docker /bin/docker
RUN apt update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:openjdk-r/ppa && \
    apt-get update && \
    apt-get install openjdk-8-jdk -y && \
    apt-get install -y lrzsz git unzip vim curl wget maven npm nodejs python3 python3-pip dnsutils net-tools && \
    rm -rf /var/lib/apt/lists/*
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
