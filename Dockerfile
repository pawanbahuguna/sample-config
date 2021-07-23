#FROM ubuntu:20.10
FROM --platform=linux/amd64 node:12.22-alpine as build
ENV PROJECT_WORKDIR=/home/node
WORKDIR $PROJECT_WORKDIR/
RUN cd $PROJECT_WORKDIR && touch TEST.txt
RUN ls -al $PROJECT_WORKDIR/TEST.txt
