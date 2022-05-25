# Multi stage build

# Build stage I : Go lang and Alpine Linux is only needed to build the program
#FROM golang:1.11-alpine AS build
FROM golang AS build

ENV location /app

WORKDIR ${location}/server

ADD ./server ${location}/server
ADD ./proto ${location}/proto

#ADD main.go ${location}/server
#ADD ../proto-gen ${location}/proto-gen


# Download all the dependencies
RUN go get -d ./...
# Install the package
RUN go install ./...


RUN CGO_ENABLED=0 go build -o /bin/grpc-user-server


# Build stage II : Go binaries are self-contained executables.
FROM scratch
COPY --from=build /bin/grpc-user-server /bin/grpc-user-server


ENTRYPOINT ["/bin/grpc-user-server"]
EXPOSE 50051