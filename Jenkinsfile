pipeline {
    agent any

    environment {
        DOCKERHUB_USER = credentials('dockerhub-username')
        DOCKERHUB_PASS = credentials('dockerhub-password')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Set Variables') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'dev') {
                        env.IMAGE_NAME = 'jprakash2306/e-commerce-react-dev'
                    } else if (env.BRANCH_NAME == 'main') {
                        env.IMAGE_NAME = 'jprakash2306/e-commerce-react-prod'
                    } else {
                        error "Unsupported branch: ${env.BRANCH_NAME}"
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                sh """
                    chmod +x build.sh
                    ./build.sh
                    docker tag e-commerce-react-app:latest $IMAGE_NAME:latest
                """
            }
        }

        stage('Login & Push to DockerHub') {
            steps {
                sh """
                    echo $DOCKERHUB_PASS | docker login -u $DOCKERHUB_USER --password-stdin
                    docker push $IMAGE_NAME:latest
                """
            }
        }

        stage('Deploy to Server') {
            steps {
                sh """
                    chmod +x deploy.sh
                    ./deploy.sh
                """
            }
        }
    }
}
