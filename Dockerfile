FROM debian:buster
LABEL maintainer "andis.cirulis@whitedigital.eu"

# Some general stuff & nginx

RUN apt update \
&& apt -y upgrade \
&& apt -y install curl wget build-essential apt-transport-https software-properties-common tzdata default-mysql-client unzip bzip2 cron vim git lsb-release ca-certificates nginx \
&& apt install -y nasm pkg-config libpng-dev automake libtool autoconf \
# Set Europe/Riga timezone
&& ln -fs /usr/share/zoneinfo/Europe/Riga /etc/localtime && dpkg-reconfigure -f noninteractive tzdata


# PHP 7.4
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
&& echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list \
&& apt update \
&& apt-get install -y php7.4-fpm \
    && apt-get install -y php7.4-mbstring php7.4-gd php7.4-bcmath php7.4-zip php7.4-xml php7.4-curl php7.4-intl php7.4-memcached php7.4-imap php7.4-pgsql php7.4-mysql php7.4-soap

# # forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
 	&& ln -sf /dev/stderr /var/log/nginx/error.log

WORKDIR /root
ADD startup.sh ./
RUN chmod a+x startup.sh

ADD php-production.ini /etc/php/7.4/fpm/php.ini

#MySQL backups
RUN mkdir /backups
RUN mkdir /backups/data
ADD mysqldump.sh /backups/
RUN chmod a+x /backups/mysqldump.sh

# Cronjobs
RUN (crontab -l ; echo "0 4 * * * /backups/mysqldump.sh >> /root/mysql_backup.log 2>&1") | crontab


# Installing Composer globally
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
&& php composer-setup.php \
&&  php -r "unlink('composer-setup.php');" \
&& mv composer.phar /usr/local/bin/composer

# Install NVM
SHELL ["/bin/bash", "--login", "-c"]
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
RUN nvm install 12 \
&& npm -g install npm

# #Expose http, https
EXPOSE 80 443

CMD ["/bin/bash"]
