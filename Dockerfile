FROM phusion/baseimage:latest
MAINTAINER Karol D Sz

ENV TZ Europe/Warsaw

ENV APP postfix
ENV APP_PORT 25
ENV APP_USER postfix
ENV APP_HOME /etc/postfix
ENV APP_RUN_PATH /etc/service/$APP
ENV APP_PRE_SETUP /etc/my_init.d/$APP.ini.sh

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get -q -y --no-install-recommends install $APP mailutils psmisc curl less net-tools lsof iproute2 tzdata

RUN apt-get clean
RUN rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

# disable cron service
RUN touch /etc/service/cron/down
# remove sshd service
RUN rm -rf /etc/service/sshd

# runit - prepare service script
RUN mkdir -p $APP_RUN_PATH
COPY $APP.run $APP_RUN_PATH/run
RUN chmod +x $APP_RUN_PATH/run
COPY $APP.sh $APP_RUN_PATH
RUN chmod +x $APP_RUN_PATH/$APP.sh
COPY ./$APP.ini.sh $APP_PRE_SETUP
RUN chmod +x $APP_PRE_SETUP

WORKDIR $APP_HOME
EXPOSE $APP_PORT
CMD ["/sbin/my_init"]
