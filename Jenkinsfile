pipeline {
    agent any

    environment {
        IMAGE = 'abode-website'
    }

    stages {
        // Job 1: build the Docker image from the Dockerfile
        stage('build') {
            steps {
                sh 'docker build -t $IMAGE:$BUILD_NUMBER .'
            }
        }

        // Job 2: start the image and check the website answers
        stage('test') {
            steps {
                sh '''
                  docker rm -f test-site || true
                  docker run -d --name test-site -p 8081:80 $IMAGE:$BUILD_NUMBER
                  sleep 5
                  curl -sf http://localhost:8081 > /dev/null
                '''
            }
            post {
                always {
                    sh 'docker rm -f test-site || true'
                }
            }
        }

        // Job 3: deploy to prod, only for commits on the master branch
        stage('prod') {
            when { branch 'master' }
            steps {
                sh '''
                  docker rm -f prod-site || true
                  docker run -d --name prod-site -p 80:80 $IMAGE:$BUILD_NUMBER
                '''
            }
        }
    }
}
