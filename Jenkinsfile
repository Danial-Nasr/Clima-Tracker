pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'Danial-Nasr/web-weather'  // Replace with your Docker image name
        
        GIT_CREDENTIALS = 'dany'  // Jenkins Git credentials ID
        DOCKER_CREDENTIALS = 'dany'  // Jenkins Docker Hub credentials ID
    }
    stages {
        stage('Pull Code from Git') {
            steps {
                script {
                    // Clone your Git repository using stored credentials
                    git credentialsId: "${GIT_CREDENTIALS}", url: 'https://github.com/Danial-Nasr/Clima-Tracker.git'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image from the Dockerfile in the repository
                    sh 'docker build -t $DOCKER_IMAGE .'
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    // Log in to Docker Hub using stored credentials
                    withCredentials([usernamePassword(credentialsId: "$DOCKER_CREDENTIALS", passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh "echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin"
                    }
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    // Push the Docker image to Docker Hub
                    sh 'docker push $DOCKER_IMAGE'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run the container from the built Docker image
                    sh 'docker run -d -p 5000:5000 $DOCKER_IMAGE'
                }
            }
        }
    }
    post {
        always {
            // Cleanup: Logout from Docker Hub
            sh 'docker logout'
        }
    }
}
