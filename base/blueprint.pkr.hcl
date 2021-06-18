variable "plugins" {
  type = list(string)
}

variable "maps" {
  type = list(object({
    name = string
    url = string
  }))
}

variable "name" {
  type = string
}

variable "version" {
  type = string
}

build {
  sources = [
    "source.docker.tuinity"
  ]

  provisioner "shell-local" {
    environment_vars = ["BUILD_PLUGINS=${join(",", var.plugins)}"]
    script = "../scripts/plugins.sh"
  }

  provisioner "shell-local" {
    environment_vars = ["BUILD_BLUEPRINT_NAME=${var.name}", "BUILD_MAPS=${jsonencode(var.maps)}"]
    script = "../scripts/maps.sh"
  }

  provisioner "file" {
    destination = "/opt/spigot"
    source = "."
  }
}
