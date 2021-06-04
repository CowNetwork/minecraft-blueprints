FROM ghcr.io/cownetwork/tuinity:1.16.5-b12d0cce AS builder
WORKDIR /opt/spigot
COPY . .
RUN ./collect.sh

FROM ghcr.io/cownetwork/tuinity:1.16.5-b12d0cce
WORKDIR /opt/spigot
COPY --from=builder /opt/spigot/ .

