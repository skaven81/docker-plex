FROM ubuntu:14.04
MAINTAINER Micheal Waltz <ecliptik@gmail.com>
#Thanks to https://github.com/bydavy/docker-plex/blob/master/Dockerfile,  https://github.com/aostanin/docker-plex/blob/master/Dockerfile, and https://github.com/timhaak/docker-plex

#Setup basic environment
ENV DEBIAN_FRONTEND=noninteractive LANG=en_US.UTF-8 LC_ALL=C.UTF-8 LANGUAGE=en_US.UTF-8

#Plex install package to download
ENV PLEXPKG=https://downloads.plex.tv/plex-media-server/0.9.15.2.1663-7efd046/plexmediaserver_0.9.15.2.1663-7efd046_amd64.deb

#Update system and install packages
RUN [ "apt-get", "-q", "update" ]
RUN [ "apt-get", "-qy", "--force-yes", "upgrade" ]
RUN [ "apt-get", "-qy", "--force-yes", "dist-upgrade" ]
RUN [ "apt-get", "install", "-qy", "--force-yes", "curl" ]

#Download Plex
RUN curl $PLEXPKG -o /var/tmp/plexmediaserver.deb

#Install Plex
RUN [ "dpkg", "--install", "--force-all", "/var/tmp/plexmediaserver.deb" ]

#Clean Up
RUN [ "apt-get", "clean" ]
RUN [ "rm", "-fr", "/var/lib/apt/lists/* /tmp/* /var/tmp/*" ]

#Volumes
VOLUME [ "/config" ]
VOLUME [ "/data" ]

#Copy start script and make executable
COPY [ "./start.sh", "/app/start.sh" ]
RUN [ "chmod", "+x",  "/app/start.sh" ]

#Expose default Plex media port
EXPOSE 32400

#Set entrypoint of Plex start script
ENTRYPOINT [ "/app/start.sh" ]
