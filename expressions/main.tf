variable "containerdata" {
   default = [{ name = awesome, port = 7000,
                name = cool, port = 7000,
                name = tubular, port = 7000,
             ]
}
}

resource "docker_container" "nginx" {
  for_each = var.containerdata
  image = docker_image.nginx.image_id
  name  = item.name

  ports {
    internal = 80
    external = item.port
  }
}















terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.22.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:1.19.6"
  keep_locally = true       // keep image after "destroy"
}

provider "random" {}

resource "random_pet" "containernamerandom" {
   length    = 3
   separator = "-"
}

resource "docker_container" "nginx" {
  count = 3
  image = docker_image.nginx.image_id
  name  = "allison-${count.index}"

  ports {
    internal = 80
    external = count.index + 9000
  }
}







