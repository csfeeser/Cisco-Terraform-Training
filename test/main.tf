variable "simpsons" {
  default = { "homer"  = 8081,
              "marge"  = 8082,
              "bart"   = 8083,
              "lisa"   = 8084,
              "maggie" = 8085, 
              "barney" = 8086
            }   
}

resource "docker_container" "nginx" {
  for_each = var.simpsons

  image = docker_image.nginx.image_id
  name  = each.key

  ports {
    internal = 80
    external = each.value
  }
}

























resource "docker_image" "nginx" {
  name         = "nginx:1.19.6"
  keep_locally = true    // keep image after "destroy"
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
