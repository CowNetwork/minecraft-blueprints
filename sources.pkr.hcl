packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source = "github.com/hashicorp/docker"
    }
  }
}


variable "tuinity-version" {
  type = string
  default = env("BUILD_TUINITY_VERSION")
}

variable "spigot-base-version" {
  type = string
  default = env("BUILD_SPIGOT_BASE_VERSION")
}

source "docker" "spigot-base" {
  image = "ghcr.io/cownetwork/spigot-base:${var.spigot-base-version}"
  commit = "true"
  run_command = ["-d", "-i", "-t", "{{.Image}}"]
}

source "docker" "tuinity" {
  image = "ghcr.io/cownetwork/tuinity:${var.tuinity-version}"
  commit = true 
  run_command = ["-d", "-i", "-t", "{{.Image}}"]
}
