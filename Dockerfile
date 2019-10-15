FROM golang:alpine

RUN apk add --no-cache git ca-certificates build-base bash

RUN go get github.com/coredns/coredns | true && \
    cd $(go env GOPATH)/src/github.com/coredns/coredns && \
    sed -i 's|hosts:hosts|ads:github.com/c-mueller/ads\nhosts:hosts|g' plugin.cfg && \
    make && \
    cp coredns /coredns

EXPOSE 53 53/udp
ENTRYPOINT ["/coredns"]