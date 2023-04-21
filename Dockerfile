FROM golang:alpine AS builder

WORKDIR /build
COPY go.mod go.sum ./
RUN go mod download && go mod verify

COPY . .
RUN go build -v -o /build ./...

FROM alpine:latest
LABEL maintainer="Ben Kochie <superq@gmail.com>"

COPY --from=builder /build/chrony_exporter /bin/chrony_exporter
COPY LICENSE /LICENSE

USER       nobody
ENTRYPOINT ["/bin/chrony_exporter"]
EXPOSE     9123
