# DevOps Final Project

## Project Name

Automated DevOps Pipeline using Vagrant and Ansible

## Description

This project demonstrates the creation of a fully automated deployment pipeline using tools such as GitHub, Vagrant, and Ansible. The pipeline is designed to deploy a Python application on two virtual machines with Ansible. The goal is to streamline the deployment process and ensure consistency across different environments.

### Features

-Integration with a private GitHub repository.

-Use of lightweight virtual machines with Vagrant.

-Execution of an Ansible playbook to manage application deployment.

-Integration with Jenkins for continuous integration and deployment.

-Integration with a private GitHub repository.

-Use of lightweight virtual machines with Vagrant.

-Execution of an Ansible playbook to manage application deployment.

### Differentiators

Compared to other automation pipelines, this project focuses on simplicity by using Vagrant and Ansible, making it ideal for small projects and learning environments.

## Visuals

### Application Running on Virtual Machines
- Screenshots of the application deployed on two Vagrant machines.

## Installation

![prerequisites](prerequisites_docker_jenkins_ansible.sh)

### Prerequisites

1. A private GitHub repository containing the provided Python code.
2. Vagrant installed on the host machine.
3. Ansible installed on the host machine.

### Steps

1. Clone the repository:
   ```bash
   git clone <your-private-repo-url>
   ```
2. Set up two virtual machines using the following `Vagrantfile`:
  ![Vagrant](Vagrant-configuration)
3. Run the Vagrant machines:
   ```bash
   vagrant up
   ```
4. Create an inventory file for Ansible to manage the Vagrant machines:
   ```ini
   [vagrant]
   192.168.45.15 ansible_ssh_user=vagrant ansible_ssh_private_key_file=.vagrant/machines/ubuntu_machine_1/virtualbox/private_key
   192.168.45.18 ansible_ssh_user=vagrant ansible_ssh_private_key_file=.vagrant/machines/ubuntu_machine_2/virtualbox/private_key
   ```
5. Write and run an Ansible playbook to deploy the application on both machines.

## Usage

- Push updates to the GitHub repository to sync application code.
- Use Ansible to deploy the updated application on the virtual machines.

### Example Output

- Access the application at `http://192.168.45.15:5000` or `http://192.168.45.18:5000` after deployment.

## Support

For any questions or support, contact:

- Email: [support@example.com](mailto:support@example.com)
- GitHub Issues: [Project Issues](https://github.com/your-private-repo/issues)

## Roadmap

- Add monitoring using Prometheus and Grafana.
- Integrate automated testing into the deployment process.
- Expand deployment to include Kubernetes.

## Contributing

Contributions are welcome! To contribute:

1. Fork the repository.
2. Create a new feature branch.
3. Submit a pull request with a clear description.

## Authors and Acknowledgments

- **Your Name** - Project Lead
- **Orange Digital Center** - Training Provider
- Special thanks to all contributors and mentors.


## Project Status

The project is functional but needs improvements, such as enhanced monitoring and automated tests. Contributions are encouraged!

