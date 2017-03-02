FROM debian:jessie

MAINTAINER Darrel Griët

ENV DEBIAN_FRONTEND noninteractive

USER root

RUN echo 'deb http://httpredir.debian.org/debian jessie non-free' >> /etc/apt/sources.list.d/jessie.non-free.list
RUN echo 'deb http://httpredir.debian.org/debian jessie-updates non-free' >> /etc/apt/sources.list.d/jessie.non-free.list
RUN echo 'deb http://security.debian.org/ jessie/updates non-free' >> /etc/apt/sources.list.d/jessie.non-free.list

RUN apt-get update
RUN apt-get install -y make autoconf automake libtool gcc g++ gperf flex bison \ 
		       texinfo gawk ncurses-dev libexpat-dev python python-serial sed \ 
		       git unzip bash wget bzip2 libtool-bin doxygen

RUN useradd -ms /bin/bash -G dialout docker

USER docker
RUN mkdir /SDK/
WORKDIR /SDK/

RUN git clone https://github.com/pfalcon/esp-open-sdk.git --recursive
WORKDIR /SDK/esp-open-sdk
RUN make 
