FROM ubuntu:12.04

# Install dependencies
RUN apt-get update zip unzip -y
RUN apt-get install -y git curl apache2 php5 libapache2-mod-php5 php5-mcrypt php5-mysql

# Install app
RUN rm -rf /var/www/*
ADD src /var/www
#ADD https://github.com/srutav/openemrdocker/archive/master.zip /tmp/
#RUN unzip /tmp/master.zip -d /var/www/
#RUN wget -O /tmp/master.zip https://github.com/srutav/openemr-latest/archive/master.zip
#RUN unzip -d /var/www/ /tmp/master.zip
#RUN chmod -R 777 /var/www/openemr-latest-master
# Configure apache
RUN a2enmod rewrite
RUN chown -R www-data:www-data /var/www
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80

CMD ["/usr/sbin/apache2", "-D",  "FOREGROUND"]
