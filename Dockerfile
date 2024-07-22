# Base image
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk gcc g++ mono-mcs python3 python3-pip && \
    apt-get clean

# Create a user for running code
RUN useradd -ms /bin/bash coder

# Switch to non-root user
USER coder

# Working directory
WORKDIR /home/coder
