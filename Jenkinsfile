pipeline {
    agent any

    environment {
        DOCKER_COMPOSE_FILE = 'docker-compose.yml'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the Dockerfile
                    sh 'docker build -t test-app:latest .'
                }
            }
        }

        stage('Docker Compose Up') {
            steps {
                script {
                    // Start the containers in detached mode
                    sh 'docker-compose -f ${DOCKER_COMPOSE_FILE} up -d'
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    // Here, we're simply checking if the app is running by hitting the homepage.
                    sh "curl --silent --fail http://localhost:3000/ || exit 1"
                }
            }
        }

        stage('Tear Down') {
            steps {
                script {
                    // Stop and remove the containers
                    sh 'docker-compose -f ${DOCKER_COMPOSE_FILE} down'
                }
            }
        }
    }

    post {
        always {
            // Cleanup even if the build fails
            sh 'docker-compose -f ${DOCKER_COMPOSE_FILE} down'
        }
    }
}
