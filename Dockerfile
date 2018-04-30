FROM centos

RUN yum clean all && yum update -y

RUN yum install -y httpd

RUN echo "Hello World." > /var/www/html/index.html

EXPOSE 80

ENTRYPOINT ["/usr/sbin/httpd","-DFOREGROUND"]