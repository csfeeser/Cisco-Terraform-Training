output "datip4address" {
  description = "IPv4 address of the resources I made"
  value       = docker_container.nginx.ip_address
}


resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "outputdemo"
  ports {
    internal = 80
    external = 8000
  }
}

