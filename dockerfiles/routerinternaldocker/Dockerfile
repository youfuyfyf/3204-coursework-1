# Download base image
FROM ubuntu:20.04

# LABEL about the custom image
LABEL Maintainer="yf"
LABEL Version="0.1"
LABEL Description="routerinternal \
https://kifarunix.com/configure-ubuntu-20-04-as-linux-router/#:~:text=Enable%20Kernel%20IP%20forwarding%20on,should%20be%20able%20to%20communicate. \
https://stackoverflow.com/questions/52595272/use-docker-container-as-network-gateway/69055795#69055795?newreg=2a08445b87fa459783c83a1c239f261c"

USER root

RUN apt-get update && \
    apt-get install -y \
						sudo \
						net-tools \
						iputils-ping \
						iproute2 \
						iptables
