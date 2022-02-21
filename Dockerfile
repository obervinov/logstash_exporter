# See: https://hub.docker.com/_/golang/
FROM golang:1.13 as golang

# Fetch the source
RUN go get -u github.com/obervinov/logstash_exporter

# Get dependencies and build!
RUN cd $GOPATH/src/github.com/obervinov/logstash_exporter && \
        make

# It looks like the `latest` tag uses uclibc
# See: https://hub.docker.com/_/busybox/
FROM busybox:latest 
COPY --from=golang /go/src/github.com/obervinov/logstash_exporter/logstash_exporter /
LABEL maintainer obervinov
EXPOSE 9198
ENTRYPOINT ["/logstash_exporter"]
