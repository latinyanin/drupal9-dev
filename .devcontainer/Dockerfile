# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.195.0/containers/php/.devcontainer/base.Dockerfile
# [Choice] PHP version (use -bullseye variants on local arm64/Apple Silicon): 8, 8.0, 7, 7.4, 7.3, 8-bullseye, 8.0-bullseye, 7-bullseye, 7.4-bullseye, 7.3-bullseye, 8-buster, 8.0-buster, 7-buster, 7.4-buster, 7.3-buster
ARG VARIANT=8-bullseye
FROM mcr.microsoft.com/vscode/devcontainers/php:0-${VARIANT}

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
  && apt-get install -y --no-install-recommends \
  mariadb-client \
  libfreetype6-dev \
  libjpeg-dev \
  libpng-dev \
  libwebp-dev \
  libpq-dev \
  libzip-dev \
  openjdk-11-jre \
  openjdk-11-jdk \
  && apt-get clean -y && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd \
  --with-freetype \
  --with-webp \
  --with-jpeg=/usr

RUN docker-php-ext-install -j "$(nproc)" gd mysqli pdo pdo_mysql zip
# [Choice] Node.js version: none, lts/*, 16, 14, 12, 10
ARG NODE_VERSION="none"
RUN if [ "${NODE_VERSION}" != "none" ]; then su vscode -c "umask 0002 && . /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"; fi

RUN sudo curl -fsSL -o /usr/local/bin/drush "https://github.com/drush-ops/drush-launcher/releases/latest/download/drush.phar" && \
  sudo chmod +x /usr/local/bin/drush

# Xdebug settings
ARG XDEBUG_MODE="off"
ARG XDEBUG_PORT="9000"
RUN xdebug_conf_path=/usr/local/etc/php/conf.d/xdebug.ini;\
  echo "xdebug.mode = $XDEBUG_MODE" > $xdebug_conf_path;\
  echo "xdebug.start_with_request = yes" >> $xdebug_conf_path;\
  echo "xdebug.client_port = $XDEBUG_PORT">> $xdebug_conf_path;\
  echo "xdebug.log=/dev/null" >> /usr/local/etc/php/conf.d/xdebug.ini;\
  echo "xdebug.client_host=host.docker.internal" >> $xdebug_conf_path;\
  echo "xdebug.discover_client_host=false" >> $xdebug_conf_path;\
  echo "xdebug.show_error_trace=0" >> $xdebug_conf_path;\
  echo "xdebug.show_local_vars=1" >> $xdebug_conf_path;\
  echo "xdebug.show_exception_trace=0" >> $xdebug_conf_path;\
  echo "xdebug.idekey=VSCODE" >> $xdebug_conf_path;

COPY ./apache.conf /etc/apache2/sites-enabled/apache.conf

RUN echo "export APACHE_RUN_USER=vscode" >> /etc/apache2/envvars;
RUN echo "export APACHE_RUN_GROUP=vscode" >> /etc/apache2/envvars;
