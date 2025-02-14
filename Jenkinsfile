pipeline {
    agent { label 'python-app' } 

    environment {
        PROJECT_NAME = "svcomforts"
        IMAGE_NAME = "korlimarlabalakrishna/python-app"
        DOCKER_HUB_USER = "korlimarlabalakrishna"
        DOCKER_HUB_REPO = "python-app"
    }

    stages { 
        stage('Git Checkout') {
            steps { 
                git credentialsId: '1a8abd76-2c99-4c88-9433-f21de6954aef', url: 'https://github.com/Korlimarlabalakrishna/python-app.git'
            }
        }

        stage('Check Existing Image Locally') {
            steps {
                script {
                    def localTag = sh(script: "docker images --format '{{.Tag}}' ${IMAGE_NAME} | sort -V | tail -n 1", returnStdout: true).trim()
                    if (localTag ==~ /^[0-9]+$/) {
                        env.LATEST_LOCAL_TAG = localTag
                    } else {
                        env.LATEST_LOCAL_TAG = "0"
                    }
                    echo "Latest Local Tag: ${env.LATEST_LOCAL_TAG}"
                }
            }
        }

        stage('Check Existing Image on Docker Hub') {
            steps {
                script {
                    sh "which jq || sudo apt-get install -y jq"  // Ensure jq is installed

                    def dockerHubTag = sh(
                        script: """curl -s https://hub.docker.com/v2/repositories/${DOCKER_HUB_USER}/${DOCKER_HUB_REPO}/tags | jq -r '.results[].name' | sort -V | tail -n 1""",
                        returnStdout: true
                    ).trim()

                    if (dockerHubTag ==~ /^[0-9]+$/) {
                        env.LATEST_DOCKER_HUB_TAG = dockerHubTag
                    } else {
                        env.LATEST_DOCKER_HUB_TAG = "0"
                    }
                    echo "Latest Docker Hub Tag: ${env.LATEST_DOCKER_HUB_TAG}"
                }
            }
        }

        stage('Determine New Build Number') {
            steps {
                script {
                    def latestTag = [env.LATEST_LOCAL_TAG.toInteger(), env.LATEST_DOCKER_HUB_TAG.toInteger()].max()
                    env.NEW_TAG = (latestTag + 1).toString()
                    echo "New Build Number: ${env.NEW_TAG}"
                }
            }
        }

        stage('Build & Push Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${NEW_TAG} ."
                sh "docker push ${IMAGE_NAME}:${NEW_TAG}"
            }
        }

        stage('Update Kubernetes Deployment') {
            steps {
                sh "kubectl set image deployment/python-app python-app=${IMAGE_NAME}:${NEW_TAG} --record"
            }
        }
    }

    post { 
        always { 
            emailext attachLog: true,  
                body: '''Hello, 

python-app deployment completed. Kindly check and confirm the same.  
python-app URL: http://23.20.2.187:31111/ 

Thanks,  
DevOps Team. ''',  
                recipientProviders: [developers()],  
                replyTo: 'krishna123.korlimarla@gmail.com',  
                subject: "${env.PROJECT_NAME} - Build # ${env.BUILD_NUMBER} - ${env.BUILD_STATUS}!", 
                to: 'bala.korlimarla@yahoo.com' 
        } 
    } 
}

