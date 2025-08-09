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
                    usernameVariable: 'dockerhub-username',
                    passwordVariable: 'dockerhub-password')]) {

                    script {
                        echo "Logging into DockerHub..."
                        sh """
                            echo "$dockerhub-password" | docker login -u "$dockerhub-username" --password-stdin
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
