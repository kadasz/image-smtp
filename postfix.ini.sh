#!/bin/bash
set -e

echo "Processing configuration file ${APP_PRE_SETUP} ..."
if [ ! -f "${APP_HOME}/.app_configured" ]; then
    if [ -n "$DOMAIN" ]; then
      postconf -e "mydomain=$DOMAIN"
      echo "Domain has been set - $DOMAIN"
    fi

    if [ -n "$HOSTNAME" ]; then
      postconf -e "myhostname=$HOSTNAME"
      echo "Hostname has been set - $HOSTNAME"
    fi

    if [ -n "$NETWORKS" ]; then
      postconf -e "mynetworks=${NETWORKS}"
      echo "Networks has been set - ${NETWORKS}"
    fi

    touch ${APP_HOME}/.app_configured
    echo "Initial configuration has been completed ..."
else
  echo "Nothing to do, exiting ..."
fi
