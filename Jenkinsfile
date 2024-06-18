pipeline 
{ 
    agent any
environment {
        DOCKER_ID = credentials('DOCKER_ID')
        DOCKER_PASSWORD = credentials('DOCKER_PASSWORD')
}

stages {
    stage('Checkout main branch') {
        steps {
           checkout scm  
        }
    }
    
    stage('Build') {
        steps {
            sh 'docker build -t your-image .'
        }
    }
    
    stage('Test') {
        steps {
            sh '''docker rm -f test-container &&
                  docker run --name test-container -p 3000:3000 -d your-image &&
                  status_code=$(curl -s -o /dev/null -w "%{http_code}" localhost:8080) || $?'''
            }
        }
    
    stage('Push to DockerHub') {
        steps {
                   sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_ID --password-stdin'
                   sh "docker tag your-image ${DOCKER_USERNAME}/your-image"
                   sh "docker push ${DOCKER_USERNAME}/your-image"
                    
                    }
                }
             }
        }

