FROM ubuntu:20.04 as builder
RUN apt update
RUN apt install curl jq -y
WORKDIR /opt/spigot
COPY . .
RUN ls -la
RUN ./collect.sh

FROM ghcr.io/cownetwork/tuinity:1.16.5-b12d0cce
COPY --from=builder /opt/spigot/ .
