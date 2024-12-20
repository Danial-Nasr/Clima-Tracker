pipeline {
    agent any
    environment {
        DOCKER_REGISTRY = 'danial773'    // Docker Hub username
        IMAGE_NAME = 'weather-app'         // Docker image name
        CONTAINER_NAME = 'weather-app-con'     // Docker container name
        DOCKER_PORT = '5000'               // Application port
        GIT_CREDENTIALS = 'Danial-Nasr1'    // Updated Git credentials ID
        DOCKER_CREDENTIALS = 'Danial-Nasr1' // Updated Docker Hub credentials ID
    }
    stages {
        stage('Pull Code from Git') {
            steps {
                git branch: 'main', url: 'https://github.com/Danial-Nasr/Clima-Tracker.git', credentialsId: 'Danial-Nasr1'
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
                withCredentials([usernamePassword(credentialsId: 'dockerhub_cread', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD'),
                             string(credentialsId: 'docker_image', variable: 'DOCKER_IMAGE')]) { // Add the secret credential here
                sh 'echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin'
                sh 'docker push ${DOCKER_IMAGE}'  
                sh 'docker logout'
 
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
