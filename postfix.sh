#!/bin/sh
# This script come from: https://raw.githubusercontent.com/siuyin/postfix-svr/master/postfix/postmon.sh
/etc/init.d/postfix start
script -qc '/usr/sbin/postfix status' | \
  grep 'mail system is running'
RC=$?
while [ $RC -eq 0 ]; do
  sleep 600
  script -qc '/usr/sbin/postfix status' | \
    grep 'mail system is running'
  RC=$?
done
