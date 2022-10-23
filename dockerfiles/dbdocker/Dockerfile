# Download base image
FROM mysql:debian

# LABEL about the custom image
LABEL Maintainer="yf, retxed"
LABEL Version="0.1"
LABEL Description="mysql \
https://jojozhuang.github.io/architecture/creating-mysql-image-with-docker-file/"

# Set environments
ENV MYSQL_ROOT_PASSWORD abc123
ENV MYSQL_DATABASE db

# The ADD command copy the database backup file 
# to /docker-entrypoint-initdb.d directory in the Docker container. 
# The docker-entrypoint.sh file will run any files in this directory 
# ending with “.sql” against the MySQL database. 
# In our example, we have only one sql script file 3204.sql
COPY 3204.sql /docker-entrypoint-initdb.d

RUN apt-get update && \
    apt-get install -y \
						net-tools \
						curl 
						
WORKDIR /home
RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-8.3.3-amd64.deb
RUN dpkg -i filebeat-8.3.3-amd64.deb
COPY filebeat.yml /etc/filebeat/
RUN chmod 644 /etc/filebeat/filebeat.yml
RUN filebeat modules enable mysql
COPY mysql.yml /etc/filebeat/modules.d/
RUN chmod 644 /etc/filebeat/modules.d/mysql.yml

COPY docker-entrypoint.sh /root/
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["filebeat setup && service filebeat start && docker-entrypoint.sh mysqld"]

