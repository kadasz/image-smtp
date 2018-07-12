FROM phusion/baseimage:latest
MAINTAINER Karol D Sz

ENV TZ Europe/Warsaw

ENV APP postfix
ENV APP_PORT 25
ENV APP_USER postfix
ENV APP_HOME /etc/postfix

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get -q -y --no-install-recommends install $APP mailutils psmisc curl less net-tools lsof iproute2 tzdata

RUN apt-get clean
RUN rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

# disable cron service
RUN touch /etc/service/cron/down

# add config file
COPY main.cf $APP_HOME

# runit - prepare service script
RUN mkdir -p /etc/service/$APP
COPY $APP.run /etc/service/$APP/run
RUN chmod +x /etc/service/$APP/run
COPY $APP.sh /etc/service/$APP/
RUN chmod +x /etc/service/$APP/$APP.sh

WORKDIR $APP_HOME
EXPOSE $APP_PORT

CMD ["/sbin/my_init"]
