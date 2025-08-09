pipeline {
   agent any

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
                       env.IMAGE_TAG = "${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
                       env.DEPLOY_CONTAINER_NAME = "reactapp-dev"
                       env.DEPLOY_PORT = "81"
                   } else if (env.BRANCH_NAME == 'main') {
                       env.IMAGE_NAME = 'jprakash2306/e-commerce-react-prod'
                       env.IMAGE_TAG = "${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
                       env.DEPLOY_CONTAINER_NAME = "reactapp-prod"
                       env.DEPLOY_PORT = "80"
                   } else {
                       error("Unsupported branch: ${env.BRANCH_NAME}")
                   }
               }
           }
       }

       stage('Build Docker Image') {
           steps {
               sh """
                  chmod +x build.sh
                  ./build.sh
                  docker tag e-commerce-react-app:latest $IMAGE_NAME:$IMAGE_TAG
               """
           }
       }

       stage('Login & Push to DockerHub') {
           steps {
               withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials-id', usernameVariable: 'dockerhub-username', passwordVariable: 'dockerhub-password')]) {
                   sh """
                      echo "$dockerhub-password" | docker login -u "$dockerhub-username" --password-stdin
                      docker push $IMAGE_NAME:$IMAGE_TAG
                   """
               }
           }
       }

       stage('Deploy Application') {
           steps {
               sh """
                  docker stop $DEPLOY_CONTAINER_NAME || true
                  docker rm $DEPLOY_CONTAINER_NAME || true
                  docker run -d -p $DEPLOY_PORT:80 --name $DEPLOY_CONTAINER_NAME $IMAGE_NAME:$IMAGE_TAG
               """
           }
       }
   }
}
