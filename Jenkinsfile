pipeline {
    agent any
    environment {
        IMAGE_NAME = "darkknight111/my-jenkins-app"
        IMAGE_TAG  = "build-${BUILD_NUMBER}"
        DOCKER_CREDS = credentials('dockerhub-creds')
    }
    stages {
        stage('Build image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
                sh 'docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest'
            }
        }
        stage('Push to Docker Hub') {
            steps {
                sh 'echo $DOCKER_CREDS_PSW | docker login -u $DOCKER_CREDS_USR --password-stdin'
                sh 'docker push ${IMAGE_NAME}:${IMAGE_TAG}'
                sh 'docker push ${IMAGE_NAME}:latest'
            }
        }
    }
    post {
        always {
            sh 'docker logout'
        }
    }
}