FROM ubuntu:14.04
MAINTAINER Micheal Waltz <ecliptik@gmail.com>
#Thanks to https://github.com/bydavy/docker-plex/blob/master/Dockerfile and https://github.com/aostanin/docker-plex/blob/master/Dockerfile

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8
ENV LC_ALL C.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apt-get -q update
RUN apt-get -qy --force-yes dist-upgrade

RUN apt-get install -qy --force-yes curl

RUN curl https://downloads.plex.tv/plex-media-server/0.9.11.7.803-87d0708/plexmediaserver_0.9.11.7.803-87d0708_amd64.deb -o /var/tmp/plexmediaserver.deb

RUN apt-get -q update

RUN dpkg --install --force-all /var/tmp/plexmediaserver.deb

# apt clean
RUN apt-get clean &&\
  rm -rf /var/lib/apt/lists/* &&\
  rm -rf /tmp/*

VOLUME /config
VOLUME /data

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

EXPOSE 32400

CMD ["/start.sh"]
