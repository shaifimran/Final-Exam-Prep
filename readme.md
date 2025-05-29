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

## Notes

- The container runs a long-lived process to stay up for Ansible.
- You can customize image and container names in Terraform variables.
- Make sure Docker is running before starting.

## References

- [Terraform Docker Provider](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs)
- [Ansible Documentation](https://docs.ansible.com/)