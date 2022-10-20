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

COPY nginx.conf /etc/nginx/
COPY web/* /var/www/html/

WORKDIR /var/www/html
RUN mkdir img
RUN mkdir uploads
RUN chmod 777 uploads
RUN mv bg.jpg ./img
RUN mv pass.jpg ./img
RUN mv user.jpg ./img

RUN mv default /etc/nginx/sites-enabled/default

WORKDIR /home
RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-8.3.3-amd64.deb
RUN dpkg -i filebeat-8.3.3-amd64.deb
COPY filebeat.yml /etc/filebeat/
RUN chmod go-w /etc/filebeat/filebeat.yml
RUN filebeat modules enable nginx
COPY nginx.yml /etc/filebeat/modules.d/
