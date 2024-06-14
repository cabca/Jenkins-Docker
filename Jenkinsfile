pipeline 
{ 
    agent any

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
            withCredentials([usernamePassword(credentialsId: "docker-hub-credentials", 
                                              usernameVariable: "DOCKER_USERNAME", 
                                              passwordVariable: "DOCKER_PASSWORD")]) 
                    {
                        sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD" 
                        sh "docker tag your-image ${DOCKER_USERNAME}/your-image"
                        sh "docker push ${DOCKER_USERNAME}/your-image"
                    }
                }
             }
        }
    }
