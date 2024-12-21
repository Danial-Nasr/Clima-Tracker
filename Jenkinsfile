pipeline {
    agent any
    environment {
        DOCKER_REGISTRY = 'danial773'         // Docker Hub username
        IMAGE_NAME = 'weather-app'            // Docker image name
        CONTAINER_NAME = 'weather-app-con'    // Docker container name
        DOCKER_PORT = '5000'                  // Application port
        GIT_CREDENTIALS = 'Danial-Nasr1'      // Git credentials ID
        DOCKER_CREDENTIALS = 'Danial-Nasr1'   // Docker Hub credentials ID
        DOCKER_USERNAME = 'danial773'         // Docker Hub username
        DOCKER_PASSWORD = 'dckr_pat_olvu_DAEYGnhU2sLho-T6pOYjcc' // Docker password
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
                    // Build the Docker image from the repository
                    sh """
                        docker build --no-cache -t ${DOCKER_REGISTRY}/${IMAGE_NAME} .
                    """
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Ensure any existing container is removed and run the new container
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
                    // Verify the container is running
                    sh """
                        docker ps | grep ${CONTAINER_NAME}
                    """
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                // Log in to Docker Hub
                sh 'echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin'

                // Tag the Docker image with your username (if it's not already tagged)
                sh 'docker tag ${DOCKER_REGISTRY}/${IMAGE_NAME} ${DOCKER_USERNAME}/${IMAGE_NAME}:latest'

                // Push the image to Docker Hub
                sh 'docker push ${DOCKER_USERNAME}/${IMAGE_NAME}:latest'

                // Log out from Docker Hub
                sh 'docker logout'
            }
        }

        // Ansible Playbook Stage
        stage('Run Ansible Playbook') {
            steps {
                dir('keys') {
                         sh 'chmod 600 keys/private_key1'
                         sh 'chmod 600 keys/private_key2'
                    }
                
                    // Run the Ansible playbook
                 /sh 'ansible-playbook -i inventory.ini playbook.yml'
                }
            }
        }
    }
    post {
        always {
            script {
                // Cleanup resources: remove container and image, logout from Docker
                sh """
                    docker rm --force ${CONTAINER_NAME} || true
                    docker rmi --force ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest || true
                    docker logout || true
                """
            }
        }
    }
}
