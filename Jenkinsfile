pipeline {
    agent any
    environment {
        DOCKER_REGISTRY = 'Danial-Nasr'    // Docker Hub username
        IMAGE_NAME = 'weather-app'         // Docker image name
        CONTAINER_NAME = 'weather-app'     // Docker container name
        DOCKER_PORT = '5000'               // Application port
        GIT_CREDENTIALS = 'Danial-Nasr1'    // Updated Git credentials ID
        DOCKER_CREDENTIALS = 'Danial-Nasr1' // Updated Docker Hub credentials ID
    }
    stages {
        stage('Pull Code from Git') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: "${GIT_CREDENTIALS}", usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASSWORD')]) {
                        // Debugging Step: Check if Git is available and verify remote URL
                        sh 'git --version' // Check Git version
                        sh "git ls-remote https://$GIT_USER:$GIT_PASSWORD@github.com/Danial-Nasr/Clima-Tracker.git" // Verify repository access with credentials

                        // Clone Git repository using credentials
                        sh "git clone https://$GIT_USER:$GIT_PASSWORD@github.com/Danial-Nasr/Clima-Tracker.git"
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image from the repository
                    sh """
                        docker build --no-cache -t ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest .
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
                        docker run -d --name ${CONTAINER_NAME} -p ${DOCKER_PORT}:${DOCKER_PORT} ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest
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
                script {
                    // Log in to Docker Hub and push the Docker image
                    withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh """
                            echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USER} --password-stdin
                            docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest
                        """
                    }
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
