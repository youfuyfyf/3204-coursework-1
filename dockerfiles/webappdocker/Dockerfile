# Download base image
FROM ubuntu:22.04

# LABEL about the custom image
LABEL Maintainer="yf"
LABEL Version="0.1"
LABEL Description="web-test"

RUN apt-get update && \
    apt-get install -y \
						sudo \
						net-tools \
						iputils-ping \
						iproute2 \
						iptables \
						curl \
						openssh-server \
						lsb-release \
						ca-certificates \
						apt-transport-https \
						software-properties-common \
						nginx

RUN add-apt-repository ppa:ondrej/php

RUN apt-get update && \ 
						DEBIAN_FRONTEND=noninteractive \
						TZ=Asia/Singapore \
						apt-get install -y \
		        php8.1
						
RUN apt-get install -y \
						php8.1-fpm \
						php8.1-mysql
						
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

WORKDIR /var/www/html
COPY web/* /var/www/html/
RUN mkdir img
RUN mv bg.jpg ./img
RUN mv pass.jpg ./img
RUN mv user.jpg ./img

RUN mv default /etc/nginx/sites-enabled/default
