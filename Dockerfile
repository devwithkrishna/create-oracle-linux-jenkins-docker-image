FROM oraclelinux:9

ARG JAVA_VERSION=11.0.22.7.1

# Update and upgrade packages
dnf makecache && dnf upgrade-y

# Install basic packages 
RUN dnf install --disableplugin=subscription-manager --setopt=install_weak_deps=0 --setopt=tsflags=nodocs -y \
    ca-certificates \
    curl \
    jq \
    unzip \
    wget \
    && dnf clean --disableplugin=subscription-manager all 

# Set JAVA_HOME env in path variable
RUN export JAVA_HOME=$(java -XshowSettings:properties -version 2>&1 > /dev/null | grep 'java.home' | awk '{print $3}' | sed 's/.$//')
ENV PATH "${JAVA_HOME}/bin:${PATH}"

