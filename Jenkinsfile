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
