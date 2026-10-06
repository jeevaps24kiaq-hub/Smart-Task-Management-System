terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

data "docker_image" "frontend" {
  name = "smart-task-management-system-main-frontend"
}

resource "docker_container" "frontend" {
  name  = "frontend-terraform"
  image = data.docker_image.frontend.image_id

  ports {
    internal = 80
    external = 5173
  }

  restart = "unless-stopped"
}
