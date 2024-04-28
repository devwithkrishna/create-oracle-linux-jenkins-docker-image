#! /bin/bash

java_version=11.0.22.7.1

# Linux
os_arch=$(uname -s); os_arch_lower=$(echo "$os_arch" | tr '[:upper:]' '[:lower:]'); echo "$os_arch_lower"

# architecture x86
os_arch=$(uname -i | cut -d'_' -f1 | tr '[:upper:]' '[:lower:]'); echo "$os_arch"

# Create the destination directory if it does not exist
mkdir -p /usr/java/

# Install Amazon correto jdk 11 
curl -LO https://corretto.aws/downloads/resources/${java_version}/amazon-corretto-${java_version}-${os_arch_lower}-${os_arch}.tar.gz \
&& mv "amazon-corretto-${java_version}-${os_arch_lower}-${os_arch}.tar.gz" "/usr/java/amazon-corretto-${java_version}-${os_arch_lower}-${os_arch}.tar.gz" \
&& cd /usr/java \
&& tar zxvf "amazon-corretto-${java_version}-${os_arch_lower}-${os_arch}.tar.gz" \
&& JAVA_HOME=/usr/java/amazon-corretto-${java_version}-${os_arch_lower}-${os_arch} \
&& export JAVA_HOME=/usr/java/amazon-corretto-${java_version}-${os_arch_lower}-${os_arch} \
&& export PATH=$JAVA_HOME/bin:$PATH \
&& echo $PATH \
&& java --version


