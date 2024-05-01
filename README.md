# create-jenkins-docker-image
This repo contains source code to create a jenkins image which can be deployed as a docker container

# Download url of Amazon Corretto jdk 11

https://corretto.aws/[latest/latest_checksum]/amazon-corretto-[corretto_version]-[cpu_arch]-[os]-[package_type].[file_extension]

# Download url for Open jdk - java 11

https://www.openlogic.com/openjdk-downloads?field_java_parent_version_target_id=406&field_operating_system_target_id=426&field_architecture_target_id=391&field_java_package_target_id=396

# Java 11 Installation

~~ Java 11 installation will be taken care by the download_install_open_jdk shell script. we will be passing the open jdk java version as an argument to Dockerfile which is later passsed as an argument to shell script at the runtime ~~

Java 11 installation will be taken care by the dnf package manger. we install open jdk 11 version

* openjdk and amazon correto manual installations was giving some issues while running jenkins along with it. so changed to default jdk11 provided by dnf package manager.

# How to run the code
* make sure docker and docker-compose are present on your machine
* clone the repo
* add your variables to .env file
* cd to the repo directory
* execute the docker-compose command as shown below

` docker-compose --env-file .env up -d or docker build -t yourimagename `

# scripts not used

* download_install_amazon_correto.sh  --> download amazon jdk 11
* download_install_open_jdk.sh  --> download open jdk 11
* get_java_version.sh  --> get available java jdk versions from oel package manager

# How everything works

* plugins.yaml --> the list of plugins installed in java once booted by default. its file name should be either plugins.yaml or plugins.txt

* config-as-code.yaml --> The jenkins/jenkins image allows you to enable or disable the setup wizard by passing in a system property named jenkins.install.runSetupWizard via the JAVA_OPTS environment variable. Users of the image can pass in the JAVA_OPTS environment variable at runtime using the --env flag to docker run. However, this approach would put the onus of disabling the setup wizard on the user of the image. Instead, you should disable the setup wizard at build time, so that the setup wizard is disabled by default.
* **To use JCasC, you need to install the Configuration as Code plugin.** [configuration-as-code](https://plugins.jenkins.io/configuration-as-code/)

* examples of how to use config as code plugin [jenkinsci/configuration-as-code-plugin](https://github.com/jenkinsci/configuration-as-code-plugin/tree/master/demos/role-strategy-auth)
# Docker compose file

```
version: '3.8'
services:
  jenkins:
    build:
      context: .
      dockerfile: Dockerfile
    restart: always
    ports:
     - 8080:8080
    container_name: ${CONTAINER_NAME}
    environment:
      - JENKINS_ADMIN=${JENKINS_ADMIN}
      - JENKINS_ADMIN_PASSWORD=${JENKINS_ADMIN_PASSWORD}
      - JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
    volumes:
      - jenkins-data:/var/jenkins_home
    networks:
      - jenkins
volumes:
  jenkins-data:
    driver: local
networks: 
  jenkins:
```

* version - version of docker-compose ure using
* services - declaring services
* jenkins - service jenkins
* build - declaring dockerfile context for build and custom dockerfile name
* restart - restart policy
* ports - exposing ports
* container_name - the name the container will get
* environment - passing variables to fill config-as-code.yaml config
* volumes - mapping volumes to local fs
* networks - creating jenkins net (for example for adding runner-containers in future)

# Public image is available 

* [dockerofkrishnadhas/oraclelinux-jenkins-docker-image](https://hub.docker.com/layers/dockerofkrishnadhas/oraclelinux-jenkins-docker-image/latest/images/sha256-6d106820a320d7c1ad8ebbf25f73a8a1d6cc56f7275f9d65c4b93c5d92e4fc80?context=explore)

_docker pull command_ : `docker pull dockerofkrishnadhas/oraclelinux-jenkins-docker-image:latest`

# Image scanning

Image scanning is done by trivy which is an open-source tool that can be used to scan Docker images for vulnerabilities.

_command used_ : `docker run -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image ${{ inputs.image_name }}:${{ inputs.tag }}` 