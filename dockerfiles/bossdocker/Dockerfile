# Download base image
FROM ubuntu:22.04

# LABEL about the custom image
LABEL Maintainer="yf"
LABEL Version="0.1"
LABEL Description="boss \
https://stackoverflow.com/questions/52595272/use-docker-container-as-network-gateway/69055795#69055795?newreg=2a08445b87fa459783c83a1c239f261c"

RUN apt-get update && \
    apt-get install -y \
						sudo \
						net-tools \
						iputils-ping \
						iproute2 \
						iptables \
						curl \
						openssh-server

RUN sed -i '/^#/!s/PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN echo 'root:root' | chpasswd

COPY personal.txt /
