# Builds a docker gui image
FROM hurricane/dockergui:x11rdp1.3

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################

# Set environment variables

# User/Group Id gui app will be executed as default are 99 and 100
ENV USER_ID=1000
ENV GROUP_ID=1000

# Gui App Name default is "GUI_APPLICATION"
ENV APP_NAME="abcde_terminal"

# Default resolution, change if you like
ENV WIDTH=1280
ENV HEIGHT=720

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

#########################################
##    REPOSITORIES AND DEPENDENCIES    ##
#########################################
#echo 'deb http://archive.ubuntu.com/ubuntu trusty main universe restricted' > /etc/apt/sources.list
#echo 'deb http://archive.ubuntu.com/ubuntu trusty-updates main universe restricted' >> /etc/apt/sources.list

# Install packages needed for app

#########################################
##          GUI APP INSTALL            ##
#########################################

# Install steps for X app
RUN apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        xterm \
        abcde \
        cd-discid \
        flac \ 
        cdparanoia \
        id3 \
        id3v2 \
        eject &&\ 
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Copy X app start script to right location
ADD files/abcde.conf /etc/abcde.conf
ADD files/startapp.sh /startapp.sh
ADD files/firstrun.sh /etc/my_init.d/firstrun.sh
RUN chmod +x /startapp.sh &&\
    chmod +x /etc/my_init.d/firstrun.sh 


#########################################
##         EXPORTS AND VOLUMES         ##
#########################################

# Place whatever volumes and ports you want exposed here:
VOLUME ["/config", "/storage/music"]
EXPOSE 8080 3389


