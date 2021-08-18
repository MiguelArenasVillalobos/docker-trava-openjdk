FROM ubuntu:bionic

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN apt update && \
    apt -y install gnupg software-properties-common locales curl wget && \
    locale-gen en_US.UTF-8 && \
    apt-get -y dist-upgrade && \
    mkdir -p /usr/share/man/man1 && \
    apt-get -y purge gnupg software-properties-common curl && \
    apt -y autoremove && \
    wget https://github.com/TravaOpenJDK/trava-jdk-11-dcevm/releases/download/dcevm-11.0.11%2B1/Openjdk11u-dcevm-linux-x64.tar.gz -O dcevm.tar.gz && \
    tar xvzf dcevm.tar.gz && \
    rm -rf dcevm.tar.gz && \
    mv dcevm-11.0.11+1 dcevm && \
    mkdir -p /usr/lib/jvm && \
    mv dcevm /usr/lib/jvm && \
    update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/dcevm/bin/java" 0 && \
    update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/dcevm/bin/javac" 0 

ENV JAVA_HOME=/usr/lib/jvm/dcevm
