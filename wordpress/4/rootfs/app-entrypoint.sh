#!/bin/bash -e

. /opt/bitnami/base/functions
. /opt/bitnami/base/helpers

print_welcome_page

echo >&2 "Setting up autoload"
    if ! grep -Fxq "require_once __DIR__.\"/../../../wp-content/vendor/autoload.php\";" /opt/bitnami/wordpress/wp-content/plugins/graphql-wp/index.php
    then
      sed -i '/namespace Mohiohio\\GraphQLWP;/a require_once __DIR__."/../../../wp-content/vendor/autoload.php";' /opt/bitnami/wordpress/wp-content/plugins/graphql-wp/index.php
    fi
    sed -i '/<?php/a require __DIR__ . "/wp-content/vendor/autoload.php";' /opt/bitnami/wordpress/wp-config.php

if [[ "$1" == "nami" && "$2" == "start" ]] || [[ "$1" == "/init.sh" ]]; then
  . /init.sh
  nami_initialize apache php mysql-client wordpress
  info "Starting wordpress... "
fi

exec tini -- "$@"
