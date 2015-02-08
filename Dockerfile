# Ubuntu with the latest golang installed and stuff needed for CI builds using Drone
# Installs via godeb

# Inspired by http://technosophos.com/2013/12/02/go-1-2-on-ubuntu-12-10.html
# Slight modification from https://github.com/palletops/docker-golang

FROM ubuntu:latest
MAINTAINER nycmonkey@gmail.com
ENV GOPATH /usr/local/lib/go
RUN apt-get -y update --no-install-recommends
RUN apt-get -y install --no-install-recommends golang-go bzr git ca-certificates openssh-client
RUN go get launchpad.net/godeb
RUN /usr/local/lib/go/bin/godeb --help
RUN apt-get -y remove golang-go
RUN apt-get -y autoremove
RUN /usr/local/lib/go/bin/godeb install
RUN rm -rf $GOPATH
RUN rm *.deb
RUN apt-get -y remove bzr
RUN apt-get -y autoremove
RUN apt-get -y autoclean
RUN apt-get -y clean
RUN go version