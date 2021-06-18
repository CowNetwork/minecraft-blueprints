# This Dockerfile is symlinked to the blueprint folders except base,
# because most of the time the Dockerfile content will be the same.
FROM ubuntu:20.04 as builder
RUN apt update
RUN apt install curl jq -y
WORKDIR /opt/spigot
COPY . .
RUN ./collect.sh

FROM ghcr.io/cownetwork/spigot-base:v0.24.1
COPY --from=builder /opt/spigot/ .
