# create-jenkins-docker-image
This repo contains source code to create a jenkins image which can be deployed as a docker container

# Download url of Amazon Corretto jdk 11

https://corretto.aws/[latest/latest_checksum]/amazon-corretto-[corretto_version]-[cpu_arch]-[os]-[package_type].[file_extension]

# Download url for Open jdk - java 11

https://www.openlogic.com/openjdk-downloads?field_java_parent_version_target_id=406&field_operating_system_target_id=426&field_architecture_target_id=391&field_java_package_target_id=396

# Java 11 Installation

Java 11 installation will be taken care by the download_install_open_jdk shell script. we will be passing the open jdk java version as an argument to Dockerfile which is later passsed as an argument to shell script at the runtime.

# How to run the code

 docker-compose --env-file .env up -d or docker build -t your image name 
 . assuming you are executing from root of repository