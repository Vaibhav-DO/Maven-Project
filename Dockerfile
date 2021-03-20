FROM centos
MAINTAINER "Aamir M. Shaikh"
RUN yum install httpd -y
RUN  yum install git -y
COPY index.html /var/www/html
COPY . /var/www/html
WORKDIR /var/www/html
RUN touch index.php
RUN echo "Hello Radical" >> /var/www/html/index.php
ENV DocumentRoot=/var/www/html/
EXPOSE 80
CMD ["-D", "FOREGROUND"]
ENTRYPOINT ["/usr/sbin/httpd"]
