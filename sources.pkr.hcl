packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source = "github.com/hashicorp/docker"
    }
  }
}



variable "docker-reg-user" {
  type = string
  default = env("DOCKER_REG_USER")
}


variable "docker-reg-pass" {
  type = string
  default = env("DOCKER_REG_pass")
}


variable "docker-reg-server" {
  type = string
  default = env("DOCKER_REG_SERVER")
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

