# Use phusion/baseimage as base image. To make your builds
# reproducible, make sure you lock down to a specific version, not
# to `latest`! See
# https://github.com/phusion/baseimage-docker/blob/master/Changelog.md
# for a list of version numbers.
FROM phusion/baseimage:0.9.19

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# ...put your own build instructions here...

ENV TERM=xterm-color
#ENV DEBIAN_FRONTEND=noninteractive



RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y abcde cd-discid flac cdparanoia id3 id3v2 eject 

ADD files/abcde.conf /etc/abcde.conf

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
