FROM cloutainer/k8s-jenkins-slave-base:v21

#
# BASE PACKAGES
#
RUN apt-get -qqy update \
    && apt-get -qqy --no-install-recommends install \
    g++ \
    build-essential \
    php
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/*

#
# COMPOSER
#
RUN curl -jkSL -o /tmp/composer-setup.php https://getcomposer.org/installer && \
    cd /tmp && php composer-setup.php && \
    mv composer.phar /usr/local/bin/composer


#
# INSTALL AND CONFIGURE
#
COPY docker-entrypoint-hook.sh /opt/docker-entrypoint-hook.sh
RUN chmod u+rx,g+rx,o+rx,a-w /opt/docker-entrypoint-hook.sh

#
# RUN
#
USER jenkins
