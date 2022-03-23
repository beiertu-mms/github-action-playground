# Build the manager binary
FROM golang:alpine3.15 AS builder

WORKDIR /
COPY . .
RUN apk update && apk add git
RUN go build -o hello

# Build the final image
FROM alpine:3.15.2

COPY --from=builder /hello /

RUN addgroup -S runner && adduser -S -G runner runner

USER runner

ENTRYPOINT ["/hello"]
