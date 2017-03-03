FROM alpine

MAINTAINER Darrel Griët

#ENV DEBIAN_FRONTEND noninteractive

USER root

RUN apk update
RUN apk add --no-cache git make cmake gcc g++ python gawk texinfo \
                       doxygen libtool bzip2 wget unzip help2man \
                       sed python-dev ncurses-dev bison flex gperf \
                       automake autoconf unrar expat-dev patch expat ca-certificates

# Update certificates, for the download part of the esp-open-sdk
RUN update-ca-certificates
#RUN useradd -ms /bin/bash -G dialout docker
# Add non root user.
RUN adduser -D -u 1000 docker
# Make root directory.
RUN mkdir /opt/
# Make 'docker' owner of /opt.
RUN chown docker:dialout /opt/
# Switch to 'docker' user
USER docker
# Set working directory to /opt.
WORKDIR /opt/
# Clone the esp-open-sdk.
RUN git clone https://github.com/pfalcon/esp-open-sdk.git --recursive
# Change to the esp-open-sdk directory.
WORKDIR /opt/esp-open-sdk
# Build the esp-open-sdk
RUN make
