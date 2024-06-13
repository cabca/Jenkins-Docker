pipeline 
{ 
    agent any

stages {
    stage('Checkout main branch') {
        steps {
            sh 'git checkout -b main'
            git 'https://github.com/mihai-pruna/Jenkins-Docker.git'
        }
    }
    
    stage('Build') {
        steps {
            sh 'git checkout -b main'
            sh 'docker build -t your-image .'
        }
    }
    
    stage('Test') {
        steps {
            sh 'run --name test-container -p 3000:3000 -d your-image'
        }
    }
    
    stage('Push to DockerHub') {
        steps {
            withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
                sh "docker tag your-image your-dockerhub-username/your-image"
                sh "docker push your-dockerhub-username/your-image"
              }
          }
      }
   }
}
