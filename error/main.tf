/* main.tf
   Alta3 Research - rzfeeser@alta3.com
   Updated to include an error condition */

# interact with docker
provider "docker" {}

# create random_ resources
provider "random" {}

# interact with time data
provider "time" {}

resource "docker_image" "nginx" {
  name         = "nginx:1.23.4"
  keep_locally = true
}

# available from random.random_pet
resource "random_pet" "nginx" {
  length = 2
}

resource "docker_container" "nginx" {
  count = 4
  image = docker_image.nginx.image_id
  name  = "nginx-${random_pet.nginx.id}-${count.index}"
  # name = "nginx-hoppy-frog-0"

  ports {
    internal = 80
    # 8000, 8001, 8002, 8003
    external = 8000 + count.index
  }
}

resource "docker_image" "redis" {
  name         = "redis:7.0.11"
  keep_locally = true
}

resource "time_sleep" "wait_120_seconds" {
  depends_on = [docker_image.redis]

  create_duration = "120s"
}

resource "docker_container" "data" {
  # wait 120 seconds after downloading the image and launching the container
  depends_on = [time_sleep.wait_120_seconds]
  image      = docker_image.redis.image_id
  name       = "data"

  ports {
    internal = 6379
    external = 6379
  }
}

/* versions.tf */

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.22.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }

    time = {
      source  = "hashicorp/time"
      version = "~> 0.7.2"
    }
  }
}


