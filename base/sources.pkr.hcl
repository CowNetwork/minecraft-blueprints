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


variable "tuinity-version" {
  type = string
  default = env("BUILD_TUINITY_VERSION")
}

source "docker" "tuinity" {
  image = "ghcr.io/cownetwork/tuinity:${var.tuinity-version}"
  commit = true 
  run_command = ["-d", "-i", "-t", "{{.Image}}"]
}
