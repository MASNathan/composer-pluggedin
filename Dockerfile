FROM composer:latest

RUN composer global require hirak/prestissimo
RUN composer global require barryvdh/composer-cleanup-plugin
RUN composer global require fancyguy/composer-security-check-plugin
