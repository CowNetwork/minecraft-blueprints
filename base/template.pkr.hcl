build {
  sources = [
    "source.docker.tuinity"
  ]
  
  // TODO: get plugins
  provisioner "shell-local" {
      
  }

  // TODO: upload plugins
  provisioner "file" {

  }

  // TODO: cleanup
  post-provisioner "shell-local" {

  }

  // same as cleanup
  error-cleanup-provisioner "shell-local" {
    inline = ["echo 'rubber ducky'> ducky.txt"]
  }
}
