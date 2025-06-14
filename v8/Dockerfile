ARG FILEBEAT_VERSION

FROM golang:1.24.4
ENV CGO_ENABLED=0
COPY beats-v8 /go/src/beats
COPY go.mod /go/src/beats
WORKDIR /go/src/beats/filebeat
RUN go mod tidy && make

FROM docker.elastic.co/beats/filebeat:$FILEBEAT_VERSION
LABEL org.opencontainers.image.description="Recompliation of Filebeat to address CVEs"
USER root
RUN apt update && apt upgrade -y
COPY --from=0 /go/src/beats/filebeat/filebeat /usr/share/filebeat/filebeat
USER filebeat
