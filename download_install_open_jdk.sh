#! /bin/bash

java_version=$1
# Linux
os_arch=$(uname -s); os_arch_lower=$(echo "$os_arch" | tr '[:upper:]' '[:lower:]'); echo "$os_arch_lower"

# architecture x86
os_arch=$(uname -i | cut -d'_' -f2 | tr '[:upper:]' '[:lower:]'); echo "$os_arch"

# Create the destination directory if it does not exist
mkdir -p /usr/java/

# Install Amazon correto jdk 11 
curl -LO https://builds.openlogic.com/downloadJDK/openlogic-openjdk/${java_version}/openlogic-openjdk-${java_version}-linux-x${os_arch}.tar.gz \
&& mv "openlogic-openjdk-${java_version}-linux-x${os_arch}.tar.gz" "/usr/java/openlogic-openjdk-${java_version}-linux-x${os_arch}.tar.gz" \
&& cd /usr/java \
&& tar zxvf "openlogic-openjdk-${java_version}-linux-x${os_arch}.tar.gz" \
&& JAVA_HOME=/usr/java/openlogic-openjdk-${java_version}-linux-x${os_arch} \
&& export JAVA_HOME=/usr/java/openlogic-openjdk-${java_version}-linux-x${os_arch} \
&& export PATH=$JAVA_HOME/bin:$PATH \
&& echo $PATH \
&& java --version
