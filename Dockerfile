FROM composer:latest

RUN composer global require \
      hirak/prestissimo \
      barryvdh/composer-cleanup-plugin \
      fancyguy/composer-security-check-plugin

RUN composer clearcache
RUN composer global show
