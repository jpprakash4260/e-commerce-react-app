pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credentials-id',
                    usernameVariable: 'DOCKERHUB_USER',
                    passwordVariable: 'DOCKERHUB_PASS')]) {

                    script {
                        echo "Logging into DockerHub..."
                        sh """
                            echo "$DOCKERHUB_PASS" | docker login -u "$DOCKERHUB_USER" --password-stdin
                        """

                        echo "Running build.sh for branch ${env.BRANCH_NAME}..."
                        sh """
                            chmod +x build.sh
                            ./build.sh ${env.BRANCH_NAME}
                        """
                    }
                }
            }
        }

        stage('Deploy Application') {
            steps {
                script {
                    echo "Running deploy.sh for branch ${env.BRANCH_NAME}..."
                    sh """
                        chmod +x deploy.sh
                        ./deploy.sh ${env.BRANCH_NAME}
                    """
                }
            }
        }
    }
}
