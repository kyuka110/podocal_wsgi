FROM ubuntu:bionic

RUN apt-get update && apt-get install -y \
    apache2 \
    apache2-dev \
    python3.6 \
    python3-pip \
    libapache2-mod-wsgi-py3
RUN pip3 install -U pip
RUN a2dismod mpm_event && a2enmod mpm_worker

COPY site.conf /etc/apache2/sites-available/000-default.conf
COPY wsgi.conf /etc/apache2/mods-available/wsgi.conf
COPY wsgi_test.py /opt/www/wsgi_test.py

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2

CMD ["apache2ctl", "-D", "FOREGROUND"]
