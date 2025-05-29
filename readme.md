# Terraform & Ansible: Ubuntu Docker Automation + Some Concepts Discussed Below

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
- **State File:** Terraform keeps track of infrastructure in a state file, which helps it know what resources exist and what needs to be changed.
- **Plan & Apply:** `terraform plan` shows what changes will be made, and `terraform apply` makes those changes.

#### How Terraform Works

1. **Write Configuration:** You define infrastructure as code in `.tf` files.
2. **Initialize:** `terraform init` sets up the working directory and downloads providers.
3. **Plan:** `terraform plan` previews changes.
4. **Apply:** `terraform apply` provisions the resources.
5. **State Management:** Terraform tracks resources in a state file for future updates or destruction.

### Ansible

- **Inventory:** The `inventory.ini` file lists the target hosts (in this case, the Docker container) for Ansible to manage.
- **Playbook:** The `playbook.yml` file defines a series of tasks to be executed on the container, such as installing Python and running a script.
- **Tasks:** Each step in the playbook (like installing packages or running commands) is a task.
- **Modules:** Ansible modules (like `apt`, `command`, or `shell`) are used to perform specific actions on the target system.
- **Handlers:** Handlers are special tasks that run only when notified, often used for actions like restarting services after a change. For example, if you install or update a package, you might notify a handler to restart a service.
- **Roles:** Roles are a way to organize playbooks and tasks into reusable components. In this simple example, roles are not used, but for larger projects, roles help structure automation.
- **Variables:** Variables allow you to customize playbooks for different environments or hosts.
- **Idempotency:** Ansible ensures that running the same playbook multiple times results in the same state, making it safe to re-run.

#### How Ansible Works

1. **Inventory:** Ansible reads the inventory to know which hosts to manage.
2. **Playbook Execution:** The playbook runs tasks in order on the target hosts.
3. **Modules:** Each task uses a module to perform an action (e.g., install a package).
4. **Handlers:** If a task notifies a handler, the handler runs at the end of the play.
5. **Output:** Ansible prints the result of each task, showing changes and outputs.

---

## Key Concepts with Code Examples

### Terraform Concepts

- **Provider:** Tells Terraform which platform to use.  
  **Example:**  
  ```hcl
  provider "docker" {
    host = "unix:///var/run/docker.sock"
  }
  ```

  **Explanation:**  
    This line tells Terraform's Docker provider to connect to the Docker daemon using the Unix socket file located at `/var/run/docker.sock`.  
    - On Linux, Docker listens on this socket by default for local connections.
    - By specifying this, Terraform can directly communicate with your local Docker engine to create and manage containers, images, etc.
    - If you were managing Docker on a remote host, you would use a different connection string (like a TCP URL).

    **In summary**:  
    This setting allows Terraform to manage Docker resources on your local machine by talking to Docker through its default Unix socket.

- **Resource:** Defines what you want to create or manage.  
  **Example:**  
  ```hcl
  resource "docker_image" "ubuntu" {
    name = "ubuntu:latest"
  }

  resource "docker_container" "my_container" {
    image = docker_image.ubuntu.latest
    name  = "my_container"
    command = ["sleep", "infinity"]
  }
  ```

- **Data Source:** Reads information about existing resources.  
  **Example:**  
  ```hcl
  data "docker_image" "ubuntu" {
    name = "ubuntu:latest"
  }
  ```

- **Variables:** Make your configuration flexible.  
  **Example:**  
  ```hcl
  variable "container_name" {
    default = "my_container"
  }
  ```

---

### Ansible Concepts

- **Inventory:** Lists the hosts to manage.  
  **Example (`inventory.ini`):**  
  ```
  [local]
  localhost ansible_connection=local
  ```

- **Playbook:** YAML file describing automation steps.  
  **Example:**  
  ```yaml
  - name: install python
    hosts: local
    vars:
      container_name: my_container
    tasks:
      - name: Install Python3 and pip in the container
        community.docker.docker_container_exec:
          container: "{{ container_name }}"
          command: /bin/sh -c "apt update && apt install -y python3 python3-pip"
  ```

- **Task:** A single action in a playbook.  
  **Example:**  
  ```yaml
  - name: Install Python3 and pip in the container
    community.docker.docker_container_exec:
      container: "{{ container_name }}"
      command: /bin/sh -c "apt update && apt install -y python3 python3-pip"
  ```

- **Module:** The tool used to perform a task (e.g., `apt`, `command`, `community.docker.docker_container_exec`).  
  **Example:**  
  ```yaml
  - name: Run a command
    command: echo "Hello"
  ```

- **Handler:** Special task triggered by a notify.  
  **Example:**  
  ```yaml
  tasks:
    - name: Install nginx
      apt:
        name: nginx
        state: present
      notify: restart nginx

  handlers:
    - name: restart nginx
      service:
        name: nginx
        state: restarted
  ```

- **Role:** A way to organize playbooks and tasks (not used in this simple project, but useful for larger ones).

- **Register:** Captures output of a task for later use.  
  **Example:**  
  ```yaml
  - name: Run a command
    command: echo "Hello"
    register: hello_output

  - name: Show output
    debug:
      msg: "{{ hello_output.stdout }}"
  ```

- **Idempotency:** Ansible ensures running the same playbook multiple times results in the same state.

---

## How Terraform and Ansible Work Together

1. **Terraform** provisions the infrastructure (Docker container).
2. **Ansible** connects to the running container, installs Python, and runs a script.
3. **Output** is captured and displayed using `register` and `debug`.

---

## Notes

- The container runs a long-lived process to stay up for Ansible.
- You can customize image and container names in Terraform variables.
- Make sure Docker is running before starting.
- For more complex automation, consider using Ansible roles and handlers for better organization and control.

## References

- [Terraform Docker Provider](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs)
- [Ansible Documentation](https://docs.ansible.com/)