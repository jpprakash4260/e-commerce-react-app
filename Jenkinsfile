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
        stage('Deploy Application') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'dev') {
                        echo "Deploying dev branch on port 81"
                        sh """
                        docker stop reactapp-dev || true
                        docker rm reactapp-dev || true
                        docker run -d -p 81:80 --name reactapp-dev ${DOCKER_DEV_REPO}:${env.BRANCH_NAME}-${env.BUILD_NUMBER}
                        """
                    } else if (env.BRANCH_NAME == 'master') {
                        echo "Deploying master branch on port 80"
                        sh """
                        docker stop reactapp-prod || true
                        docker rm reactapp-prod || true
                        docker run -d -p 80:80 --name reactapp-prod ${DOCKER_PROD_REPO}:${env.BRANCH_NAME}-${env.BUILD_NUMBER}
                        """
                    }
                }
            }
        }
    }
}
