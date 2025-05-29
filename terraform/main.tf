terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.6.0"
    }
  }
}

provider "docker" {
  host = var.docker_host
}

# Pulls the image
resource "docker_image" "ubuntu" {
  name = var.image_name
}

# Create a container
resource "docker_container" "my_container" {
  image   = docker_image.ubuntu.name
  name    = var.container_name
  command = ["/bin/bash", "-c", "while true; do sleep 3600; done"]
}