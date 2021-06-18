packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source = "github.com/hashicorp/docker"
    }
  }
}

/*
source "docker" "spigot-base" {
  image = "ghcr.io/cownetwork/spigot-base:${var.spigot-base-version}"
  commit = "true"
}*/

source "docker" "tuinity" {
  image = "ghcr.io/cownetwork/tuinity:1.16.5-b12d0cce"
  commit = true 
  run_command = ["-d", "-i", "-t", "{{.Image}}"]
}
