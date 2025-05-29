output "container_id" {
  description = "Stores the container id of the container created by the Docker provider."
  value       = docker_container.my_container.id
}