FROM debian:jessie

MAINTAINER Darrel Griët

ENV DEBIAN_FRONTEND noninteractive

USER root

RUN echo 'deb http://httpredir.debian.org/debian jessie non-free' >> /etc/apt/sources.list.d/jessie.non-free.list
RUN echo 'deb http://httpredir.debian.org/debian jessie-updates non-free' >> /etc/apt/sources.list.d/jessie.non-free.list
RUN echo 'deb http://security.debian.org/ jessie/updates non-free' >> /etc/apt/sources.list.d/jessie.non-free.list

RUN apt-get update
RUN apt-get install -y make autoconf automake libtool gcc g++ gperf flex bison \ 
		       texinfo gawk ncurses-dev libexpat-dev python python-dev python-serial sed \ 
		       git help2man unzip bash wget bzip2 libtool-bin doxygen \
		       screen bison gperf flex texinfo help2man gawk libncurses-dev python python-serial

RUN useradd -ms /bin/bash -G dialout docker
RUN mkdir /SDK/
RUN chown docker:dialout /SDK/
USER docker
WORKDIR /SDK/

RUN git clone https://github.com/pfalcon/esp-open-sdk.git --recursive
WORKDIR /SDK/esp-open-sdk
RUN make 
