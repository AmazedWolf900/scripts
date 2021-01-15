FROM php:fpm-alpine

CMD ["php-fpm"]

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

#RUN chmod +x /usr/local/bin/install-php-extensions && sync && \
#    install-php-extensions gd xdebug intl mysqli

EXPOSE 9000