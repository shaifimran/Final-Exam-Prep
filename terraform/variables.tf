variable "image_name" {
  description = "The name of the Docker image to use"
  type        = string
  default     = "ubuntu:latest"
}
variable "container_name" {
  description = "The name of the Docker container to create"
  type        = string
  default     = "my_container"
}
variable "docker_host" {
  description = "The Docker host URI"
  type        = string
  default     = "unix:///var/run/docker.sock"
}