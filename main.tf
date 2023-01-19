terraform {
  backend "local" {
    path = "/home/ctvedt/tfstate/terraform.tfstate"
  }
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.21.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx1" {
  image = docker_image.nginx.image_id
  name  = "nginx1"
  ports {
    internal = 80
    external = 8019
  }
}

resource "docker_container" "nginx_2" {
  image = docker_image.nginx.image_id
  name  = "nginx2"
  ports {
    internal = 80
    external = 8020
  }
}
