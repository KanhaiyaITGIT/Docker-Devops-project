pipeline {
    agent any
    environment {
        IMAGE_NAME = "dockerimg"
        CONTAINER_NAME = "myweb"
        PORT = "8084"
    }
    stages {
        stage('git checkout') {
            steps {
                echo "cloning repository"
                git url: "https://github.com/KanhaiyaITGIT/Docker-Devops-project.git", branch: "main"
                echo "repository cloned successfully"
            }
        }
        stage('docker image') {
            steps {
                echo "docker image creating...."
                sh "docker build -t ${IMAGE_NAME}:latest ."
                echo "docker image created successfully"
            }
        }
        stage('docker container') {
            steps {
                echo "Docker container is being created"
                sh "docker run -d --name ${CONTAINER_NAME} -p ${PORT}:80 ${IMAGE_NAME}:latest"
                echo "container is running"
            }
        }
        stage('status checking') {
            steps {
                echo "checking contianer health"
                sh "sleep 5"
                sh "curl http://localhost:${PORT} || exit 1"
            }
        }
        stage('docker image push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-cred', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh '''
                    echo $PASS | docker login -u $USER --password-stdin
                    docker tag ${IMAGE_NAME}:latest $USER/${IMAGE_NAME}:latest
                    docker push $USER/${IMAGE_NAME}:latest
                    '''
                }
            }
        }
    }
    post {
        success {
            echo "pipeline created succeessfully"
        }
        failure {
            echo "pipeline failed... check logs"
        }
    }
}
