FROM centos:centos7
MAINTAINER Daniil Seredov <dseredov@yandex.ru>

RUN yum update -y
RUN yum install -y epel-release

# Common libs
RUN yum install -y \
    wget \
    tar

# For compiling
RUN yum install -y \
    gcc \
    gcc-c++ \
    cpp \
    make

# Download and extract Asterisk source
WORKDIR /usr/src/asterisk
RUN wget https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-15.7.1.tar.gz
RUN tar -zxvf asterisk-15.7.1.tar.gz

# Install Asterisk dependencies
WORKDIR /usr/src/asterisk/asterisk-15.7.1
RUN ./contrib/scripts/install_prereq install

# Compiling Asterisk
RUN make clean
RUN ./configure
RUN make menuselect
RUN make && make install

# Make samples and initscript
RUN make samples
RUN make config


# Make sure the default asterisk service is enabled