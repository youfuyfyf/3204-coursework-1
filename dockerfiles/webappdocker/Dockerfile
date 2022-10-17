# Download base image
FROM trafex/php-nginx

# LABEL about the custom image
LABEL Maintainer="yf, retxed"
LABEL Version="0.1"
LABEL Description="trafex/php-nginx \
https://www.howtoforge.com/tutorial/how-to-create-docker-images-with-dockerfile/"

# USER root
COPY --chown=nginx web/* /var/www/html/
