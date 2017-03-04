FROM debian:jessie

MAINTAINER Darrel Griët

ENV DEBIAN_FRONTEND noninteractive
# Switch to `root` user.
USER root

# Udate resources.
RUN apt-get -y update
# Install appropriate packages.
RUN apt-get install -y git make cmake gcc g++ python python-serial gawk texinfo \
                       doxygen libtool bzip2 wget unzip help2man libtool-bin \
                       sed python-dev libncurses-dev ncurses-dev bison flex gperf sed \
                       automake autoconf libexpat-dev expat ca-certificates

# Update certificates, for the download part of the esp-open-sdk
RUN update-ca-certificates
# Add non root user.
RUN useradd -ms /bin/bash -G dialout docker
# Make 'docker' owner of /opt.
RUN chown docker:dialout /opt/
# Switch to 'docker' user
USER docker
# Set working directory to /opt.
WORKDIR /opt/
# Clone the esp-open-sdk.
RUN git clone --recursive https://github.com/pfalcon/esp-open-sdk.git
# Change to the esp-open-sdk directory.
WORKDIR /opt/esp-open-sdk
# Build the esp-open-sdk.
RUN make
# Add the Xtensa path to the $PATH variable.
ENV PATH /opt/esp-open-sdk/xtensa-lx106-elf/bin:$PATH
