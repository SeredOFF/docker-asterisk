FROM centos:centos7
MAINTAINER Daniil Seredov <dseredov@yandex.ru>

RUN yum update -y && yum install -y epel-release \
# Common libs
    wget \
    tar \
# For compiling
    gcc \
    gcc-c++ \
    cpp \
    make

# Download and extract Asterisk source
WORKDIR /usr/local/src
RUN wget https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-15.7.1.tar.gz && \
    tar -zxvf asterisk-15.7.1.tar.gz

# Install Asterisk dependencies
WORKDIR /usr/local/src/asterisk-15.7.1
RUN ./contrib/scripts/install_prereq install && ./contrib/scripts/get_mp3_source.sh

# Compiling Asterisk
RUN make clean && ./configure
# Configure compiler options via menuselect
RUN make menuselect.makeopts && menuselect/menuselect \
    --enable format_mp3 \
    --enable codec_opus \
    --enable CORE-SOUNDS-EN-WAV \
    --enable CORE-SOUNDS-EN-G722 \
    --enable EXTRA-SOUNDS-EN-GSM \
    --enable EXTRA-SOUNDS-EN-WAV \
    --enable EXTRA-SOUNDS-EN-G722 \
    --enable app_statsd \
    --enable chan_pjsip \
    menuselect.makeopts
RUN make && make install

# Make samples, configs and logrotation script (compress and rotate logfiles)
RUN make samples && make config && make install-logrotate

# Import custom configs
COPY ./configs /etc/asterisk

# Start Asterisk
CMD service asterisk start