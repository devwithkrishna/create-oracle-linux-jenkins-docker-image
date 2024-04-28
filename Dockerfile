FROM oraclelinux:9

ARG JAVA_VERSION=11.0.22+7

# Update and upgrade packages
RUN dnf makecache && dnf upgrade-y

# Install basic packages 
RUN dnf install --disableplugin=subscription-manager --setopt=install_weak_deps=0 --setopt=tsflags=nodocs -y \
    ca-certificates \
    curl \
    jq \
    unzip \
    wget \
    && dnf clean --disableplugin=subscription-manager all 

# Install Open jdk 11 
COPY download_install_open_jdk.sh .
RUN chmod +x download_install_open_jdk.sh && ./download_install_open_jdk.sh ${JAVA_VERSION}
