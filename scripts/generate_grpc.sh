#!/bin/bash

protoc \
    --go_out=server \
    --go_opt=paths=source_relative \
    --go-grpc_out=server \
    --go-grpc_opt=paths=source_relative \
    proto/users.proto

protoc \
    --dart_out=grpc:client/lib/src/gen \
    -Iproto proto/users.proto
