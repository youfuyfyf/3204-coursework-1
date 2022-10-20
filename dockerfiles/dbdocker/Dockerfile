# Download base image
FROM mysql

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
