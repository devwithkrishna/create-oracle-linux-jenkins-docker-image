#! /bin/bash

# Update the package list
dnf makecache && dnf upgrade -y

# List available Java packages
dnf search java-*openjdk | grep -E '^java-' | awk '{print $1}'


