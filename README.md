# DevOps Final Project

## Project Name

Automated DevOps Pipeline using Vagrant and Ansible

## Description

This project demonstrates the creation of a fully automated deployment pipeline using GitHub, Vagrant, and Ansible. The pipeline automates the deployment of a Python application onto two virtual machines, managing the entire lifecycle from code push to application deployment. The goal is to streamline the deployment process, enhance environment consistency, and provide a reusable pipeline for continuous integration and deployment (CI/CD).
![Description](images/image4.jpg)

### Features

-Integration with a private GitHub repository.

-Use of lightweight virtual machines with Vagrant.

-Execution of an Ansible playbook to manage application deployment.

-Integration with Jenkins for continuous integration and deployment.

-Integration with a private GitHub repository.

-Use of lightweight virtual machines with Vagrant.

-Execution of an Ansible playbook to manage application deployment.

### Differentiators

This project stands out by offering a simple yet powerful approach to DevOps automation using Jenkins, Ansible, and vagrant. It's optimized for smaller applications or learning environments, providing a clean and minimalistic solution that ensures smooth, reliable, and automated deployments with fewer resources.

# Visuals

### The Output of these steps should be the success of the pipeline

![The Output of these steps should be the success of the pipeline](images/image3.png)
-The Weather app should be working on the two vagrant machines
![The Weather app should be working on the two vagrant machines](images/image1.jpg)
-Result
![Result](images/image2.jpg)
### Application Running on Virtual Machines
- Screenshots of the application deployed on two Vagrant machines.

# Installation  
###   prerequisites_docker_jenkins_ansible.sh
![prerequisites](prerequisites_docker_jenkins_ansible.sh)


- **Purpose**: Automates installation of Docker, Jenkins, and Ansible on Ubuntu.
- **Steps**:
  - Updates system packages.
  - Installs required dependencies.
  - Adds official repositories for Docker, Jenkins, and Ansible.
  - Installs Docker, Jenkins, and Ansible.
  - Adds the user to the `docker` group.
  - Tests if Docker, Jenkins, and Ansible are working.
- **Usage**:  
  Run the script with your username:  
  ```bash
  ./install_prerequisites.sh <your-username>
  ```
- **Requirements**:  
  - Ubuntu 20.04+  
  - User with `sudo` privileges  
- **Note**: Log out and back in after installing Docker to apply group changes.

### Prerequisites

1. A private GitHub repository containing the provided Python code.
2. Vagrant installed on the host machine.
3. Ansible installed on the host machine.

 # Steps
### Project Workflow: From Code to Deployment 
- The CI/CD pipeline is operational but requires further improvements for optimization and efficiency.  
   **Jenkins Setup with Plugins**  
- Install required Jenkins plugins for GitHub and Docker.  
- Configure Jenkins credentials for Docker Hub.  

**Jenkins Pipeline** 
- Verify repository existence; clone if absent.  
- Retrieve updates using `git fetch`.  
- Ensure local commits match remote; pull changes if necessary.  
- Build and push Docker images to Docker Hub.  
- Set up GitHub webhook for Jenkins integration using ngrok.  

**SSH Key Creation**  
- Generate SSH keys for the Vagrant machines.  

**Log File Configuration**  
- Update log file settings to resolve issues.  

 **Ansible Inventory**
- Create an inventory file to manage Vagrant machine configurations.  

**Ansible Playbook** 
- Develop an Ansible playbook to automate deployment tasks.  

 **Ansible in Jenkins** 
- Integrate Ansible steps into Jenkins and update the Jenkinsfile accordingly.  





## Usage

- Push updates to the GitHub repository to sync application code.
- Use Ansible to deploy the updated application on the virtual machines.

### Example Output

- Access the application at `http://192.168.45.15:5000` or `http://192.168.45.18:5000` after deployment.



## Roadmap

- Implement monitoring and alerting using Prometheus and Grafana.  
- Add automated testing to the CI/CD pipeline.  
- Transition to Kubernetes for broader deployment capabilities.  
- Improve pipeline efficiency and reduce manual configurations.  

## Contributing

Contributions are welcome! To contribute:

1. Fork the repository.
2. Create a new feature branch.
3. Submit a pull request with a clear description.

## Project Status

The project is fully functional, achieving automated deployment of a Python application using Jenkins, Vagrant, and Ansible. It integrates CI/CD practices with GitHub and deploys the application on virtual machines. While successful, monitoring, testing, scalability, and optimization improvements are needed. Future enhancements include adding Prometheus and Grafana for monitoring, integrating automated testing, and expanding deployment capabilities with Kubernetes. The project is open to contributions to refine its features and achieve these goals.

