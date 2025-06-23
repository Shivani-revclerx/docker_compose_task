pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Shivani-revclerx/docker_compose_task.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker Image"
                    sh 'docker build -t test-app:latest .'
                }
            }
        }

        stage('Docker Compose Up') {
            steps {
                script {
                    echo "Starting containers with docker-compose"
                    sh "docker-compose -f docker-compose.yml up -d"
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    echo "Running tests"
                    sh "curl --silent --fail http://localhost:3000/ || exit 1"
                }
            }
        }

        stage('Tear Down') {
            steps {
                script {
                    echo "Tearing down containers"
                    sh "docker-compose -f docker-compose.yml down"
                }
            }
        }
    }

    post {
        always {
            // Cleanup even if the build fails
            echo "Post-build cleanup"
            sh "docker-compose -f docker-compose.yml down || true"
        }
    }
}
