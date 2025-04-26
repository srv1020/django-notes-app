@Library("srvp") _
pipeline{

    agent {label "dev"}
    
    stages{
        
        stage("Welcome"){
            steps {
                script{
                    hello()
                }
            }
        }
        stage("code"){
            steps{
                script{
                clone("https://github.com/srv1020/django-notes-app.git","main")
                }
            }
        }
        stage("build"){
            steps{
                script{
                docker_build("srvpndy","notes-app","latest")
                }
            }
        }
        stage("push"){
            steps{
                script{
                    docker_push("notes-app", "latest", "srvpndy")
                }
            }
        }
        stage("deploy"){
            steps{
                echo "this is deploying the code"
                sh "docker-compose up -d "
            }
        }
    }
}
