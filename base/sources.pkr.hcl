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

source "docker" "tuinity" {
  image = "ghcr.io/cownetwork/tuinity:${var.tuinity-version}"
  commit = true 
  run_command = ["-d", "-i", "-t", "{{.Image}}"]
}
