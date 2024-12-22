# DevOps Final Project

## Project Name

Automated DevOps Pipeline using Jenkins, Docker, and Ansible

## Description

This project demonstrates the creation of a fully automated DevOps pipeline using tools such as GitHub, Docker, Vagrant, Jenkins, and Ansible. The pipeline is designed to containerize a Python application, build and push a Docker image, and deploy it on two virtual machines using Ansible. The goal is to streamline the deployment process and ensure consistency across different environments.

### Features

- Integration with a private GitHub repository.
- Automatic Docker image creation and pushing to Docker Hub.
- Use of lightweight virtual machines with Vagrant.
- Execution of an Ansible playbook to manage Docker installation and container orchestration.
- Fully automated CI/CD pipeline with Jenkins.

### Differentiators

Compared to other automation pipelines, this project provides step-by-step integration with Jenkins, Vagrant, and Ansible, making it ideal for small projects and learning environments.

## Badges

&#x20;&#x20;

## Visuals

### Pipeline Overview
- Jenkins Pipeline stages: Pull Code, Build Docker Image, Run Container, Push Docker Image to Docker Hub, and Run Ansible Playbook.

### Application Running on Virtual Machines
- Screenshots of the application deployed on two Vagrant machines.

## Installation

### Prerequisites

1. A private GitHub repository containing the provided Python code.
2. Docker installed on the host machine.
3. Vagrant installed on the host machine.
4. Jenkins set up with necessary plugins (GitHub, Docker, Ansible).
5. Ansible installed on the host machine.

### Steps

1. Clone the repository:
   ```bash
   git clone <your-private-repo-url>
   ```
2. Use the following `Dockerfile` for containerizing the application:
   ```dockerfile
   # Use an official Python runtime as a parent image
   FROM python:3.9-slim

   # Set the working directory in the container
   WORKDIR /app

   # Copy the application code into the container
   COPY . /app

   # Install the required dependencies
   RUN pip install --no-cache-dir -r requirements.txt

   # Expose the application's port
   EXPOSE 5000

   # Set environment variable for Flask
   ENV FLASK_APP=app.py

   # Command to run the application
   CMD ["flask", "run", "--host=0.0.0.0"]
   ```
3. Set up two virtual machines using the following `Vagrantfile`:
   ```ruby
   Vagrant.configure("2") do |config| 
     # Define the first ubuntu machine
     config.vm.define "ubuntu_machine_1" do |machine|
       machine.vm.box = "ubuntu/jammy64"
       machine.vm.network "private_network", ip: "192.168.45.15"
       machine.vm.provider "virtualbox" do |vb|
         vb.memory = "512"
         vb.cpus = "1"
       end
     end

     # Define the second ubuntu machine
     config.vm.define "ubuntu_machine_2" do |machine|
       machine.vm.box = "ubuntu/jammy64"
       machine.vm.network "private_network", ip: "192.168.45.18"
       machine.vm.provider "virtualbox" do |vb|
         vb.memory = "512"
         vb.cpus = "1"
       end
     end
   end
   ```
4. Configure Jenkins using the following pipeline script:
   ```groovy
   pipeline {
       agent any
       environment {
           DOCKER_REGISTRY = 'danial773'
           IMAGE_NAME = 'weather-app'
           CONTAINER_NAME = 'weather-app-con'
           DOCKER_PORT = '5000'
           GIT_CREDENTIALS = 'Danial-Nasr1'
           DOCKER_CREDENTIALS = 'Danial-Nasr1'
           DOCKER_USERNAME = 'danial773'
           DOCKER_PASSWORD = 'dckr_pat_olvu_DAEYGnhU2sLho-T6pOYjcc'
       }
       stages {
           stage('Pull Code from Git') {
               steps {
                   git branch: 'main', url: 'https://github.com/Danial-Nasr/Clima-Tracker.git', credentialsId: "${GIT_CREDENTIALS}"
               }
           }

           stage('Build Docker Image') {
               steps {
                   script {
                       sh """
                           docker build --no-cache -t ${DOCKER_REGISTRY}/${IMAGE_NAME} .
                       """
                   }
               }
           }

           stage('Run Docker Container') {
               steps {
                   script {
                       sh """
                           docker rm -f ${CONTAINER_NAME} || true
                           docker run -d --name ${CONTAINER_NAME} -p ${DOCKER_PORT}:${DOCKER_PORT} ${DOCKER_REGISTRY}/${IMAGE_NAME}
                       """
                   }
               }
           }

           stage('Test Container') {
               steps {
                   script {
                       sh """
                           docker ps | grep ${CONTAINER_NAME}
                       """
                   }
               }
           }

           stage('Push Docker Image to Docker Hub') {
               steps {
                   script {
                       sh 'echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin'
                       sh 'docker tag ${DOCKER_REGISTRY}/${IMAGE_NAME} ${DOCKER_USERNAME}/${IMAGE_NAME}:latest'
                       sh 'docker push ${DOCKER_USERNAME}/${IMAGE_NAME}:latest'
                       sh 'docker logout'
                   }
               }
           }

           stage('Run Ansible Playbook') {
               steps {
                   script {
                       sh 'chmod 600 keys/private_key1 keys/private_key2'
                       sh 'ansible-playbook -i inventory.ini playbook.yml'
                   }
               }
           }
       }
       post {
           always {
               script {
                   sh """
                       docker rm --force ${CONTAINER_NAME} || true
                       docker rmi --force ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest || true
                       docker logout || true
                   """
               }
           }
       }
   }
   ```
5. Execute the pipeline and verify the results.

## Usage

- To run the pipeline, push updates to the GitHub repository.
- The pipeline will automatically build and push the Docker image, then deploy the application on the virtual machines.

### Example Output

- Access the application at `http://<vagrant-machine-ip>:5000` after deployment.

## Support

For any questions or support, contact:

- Email: [support@example.com](mailto:support@example.com)
- GitHub Issues: [Project Issues](https://github.com/your-private-repo/issues)

## Roadmap

- Add monitoring using Prometheus and Grafana.
- Integrate automated testing into the pipeline.
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

## License



## Project Status

The project is functional but needs improvements, such as enhanced monitoring and automated tests. Contributions are encouraged!

