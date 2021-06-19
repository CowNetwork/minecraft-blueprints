variable "plugins" {
  type = list(string)
}

variable "maps" {
  type = list(object({
    name = string
    url = string
  }))
  default = []
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

  
  // move symlinks before uploading files 
  // because docker builder cant handle those
  provisioner "shell-local" {
    inline = [
      "mv sources.pkr.hcl /tmp/sources.hcl",
      "mv blueprint.pkr.hcl /tmp/blueprint.hcl"
    ]
  }
  
  provisioner "file" {
    destination = "/opt/spigot"
    source = "."
  }
  
  // restore prevoius state
  provisioner "shell-local" {
    inline = [
      "mv /tmp/sources.hcl sources.pkr.hcl",
      "mv /tmp/blueprint.hcl blueprint.pkr.hcl"
    ]
  }

  post-processors {
    post-processor "docker-tag" {
      repository = "ghcr.io/cownetwork/${var.name}"
      tags = ["${var.version}"]
    }
    post-processor "docker-push" {
      login_username = "${var.docker-reg-user}"
      login_password = "${var.docker-reg-pass}"
      login_server = "${var.docker-reg-server}"
      login = true
    }
  }
}
