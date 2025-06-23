pipeline {
  agent any

  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/Shivani-revclerx/docker_compose_task.git'
      }
    }
    stage('Build Docker Image') {
      steps {
        sh 'docker build -t my-node-app:latest .'
      }
    }
    stage('Start Containers') {
      steps {
        sh 'docker-compose up -d'
      }
    }
    stage('Run Tests') {
      steps {
        sh 'docker-compose exec app npm test'
      }
    }
    stage('Teardown') {
      steps {
        sh 'docker-compose down'
      }
    }
  }
  post {
        always {
            // Cleanup containers, networks, and volumes after each run
            sh 'docker-compose down'
        }
    }
}
