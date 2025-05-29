# Terraform & Ansible: Ubuntu Docker Automation

This project uses **Terraform** to create a Docker container from the Ubuntu base image, and **Ansible** to install Python inside the container and print "Hello World". All steps are performed on a Linux system.

## Prerequisites

- Linux OS
- Docker installed and running
- Terraform installed
- Ansible installed

## Steps

1. **Clone the repository:**
   ```sh
   git clone <repo-url>
   cd Final-Exam-Prep
   ```

2. **Provision the Docker container with Terraform:**
   ```sh
   cd terraform
   terraform init
   terraform plan
   terraform apply
   ```
   This will pull the Ubuntu image and start a container.

3. **Configure the container with Ansible:**
   ```sh
   cd ../ansible
   ansible-playbook -i inventory.ini playbook.yml
   ```
   This installs Python and runs a script to print "Hello World".

## Project Structure

- `terraform/` – Terraform files for Docker container provisioning
- `ansible/` – Ansible playbook and inventory for configuration
- `readme.md` – Project documentation

## Output Example

```
TASK [Print Hello World output]
ok: [default] => {
    "msg": "Hello World"
}
```

## Concepts Used

### Terraform

- **Provider:** The [Docker provider](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs) allows Terraform to interact with Docker and manage containers, images, and other Docker resources.
- **Resource:** The `docker_container` resource is used to define and create the Ubuntu container. The `docker_image` resource is used to pull the Ubuntu image.
- **Data Source:** Data sources in Terraform allow you to fetch information about existing resources, such as pulling the latest Ubuntu image.
- **Variables:** Variables are used to make the configuration flexible (e.g., container name, image version).

### Ansible

- **Inventory:** The `inventory.ini` file lists the target hosts (in this case, the Docker container) for Ansible to manage.
- **Playbook:** The `playbook.yml` file defines a series of tasks to be executed on the container, such as installing Python and running a script.
- **Tasks:** Each step in the playbook (like installing packages or running commands) is a task.
- **Modules:** Ansible modules (like `apt`, `command`, or `shell`) are used to perform specific actions on the target system.
- **Roles:** Roles are a way to organize playbooks and tasks, but in this simple example, roles are not used. For larger projects, roles help structure reusable automation.

## Notes

- The container runs a long-lived process to stay up for Ansible.
- You can customize image and container names in Terraform variables.
- Make sure Docker is running before starting.

## References

- [Terraform Docker Provider](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs)
- [Ansible Documentation](https://docs.ansible.com/)