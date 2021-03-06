FROM centos:6.6

MAINTAINER Philipp Frenzel <frp@informatec.com>

RUN yum update -y \
    && yum install -y \
	   tar \
       bash \
	   tree \
	   wget \
	   sudo \
	   vim \
	   iputils-ping \
	   less \
	   vim \
    && yum clean all 
# \
# && rm -rf /var/lib/apt/lists/*

# adding the startup script
COPY jedox.sh ./
RUN chmod +x ./jedox.sh

# add folder share Org: /share New: ./share:
VOLUME "/share"

# change to user root
USER root

# add rights
RUN chmod -R 777 /tmp

# mount the proc folder
# RUN sudo mount -t proc proc /proc

# download software
ADD https://www.jedox.com/downloads/software/2018/2/Jedox_premium_lin_2018_2.tar /tmp/

# extract software
RUN tar -xvf /tmp/Jedox_premium_lin_2018_2.tar -C /tmp/

# change to working directory /tmp
WORKDIR /tmp

# install software
RUN ./install.sh --automatic

# RUN mount -o bind "/dev" "$INSTALL_PATH/dev"
# RUN mount -o bind "/sys" "$INSTALL_PATH/sys"

# cleanup
RUN rm -rfv /tmp/*
#RUN rm -rfv /tmp/.lic_agr_7.1

# change to working directory
WORKDIR /

# add entrypoint
ENTRYPOINT /opt/jedox/ps/jedox-suite.sh start && /bin/bash
