FROM golang:1.23.8
ENV CGO_ENABLED=0
WORKDIR /go/src
RUN git clone https://github.com/elastic/beats.git && cd beats && git checkout 7.17
COPY go.mod /go/src/beats
WORKDIR /go/src/beats/filebeat
RUN go mod tidy && make

FROM docker.elastic.co/beats/filebeat:7.17.28
LABEL org.opencontainers.image.description Recompliation of Filebeat to address CVEs
USER root
RUN apt update && apt upgrade -y
COPY --from=0 /go/src/beats/filebeat/filebeat /usr/share/filebeat/filebeat
USER filebeat
