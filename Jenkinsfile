pipeline {
    agent any
    options {
    buildDiscarder(logRotator(numToKeepStr: '30', artifactNumToKeepStr: '10'))
  }
    stages {
        stage('Build') {
            steps {
                sh '''
                echo "--- Starting build --------------------------------------------------------------------------------"
                docker build -t alpache:v${BUILD_NUMBER} .
                docker tag alpache:v${BUILD_NUMBER} bohdan1993/alpache:v${BUILD_NUMBER}
                echo "=== Build finished ================================================================================"
                '''
            }
        }

        stage('Push_to_hub') {
            steps {
                sh '''
                echo "--- Starting push to DockerHub -------------------------------------------------------------------"
                bash /home/ubuntu/dockerhub/rmi_dockerhub.sh
                cat /home/ubuntu/dockerhub/pass.txt | docker login -u "bohdan1993" --password-stdin
                docker push bohdan1993/alpache:v${BUILD_NUMBER}
                docker image prune -a -f
                echo "=== Push finished ================================================================================"
                '''
            }
        }
        
        stage('Deploy') {
            steps {
                sshPublisher(publishers: [sshPublisherDesc(configName: 'web_srv', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '''
                echo "--- Starting deploy --------------------------------------------------------------------------------"
                docker stop $(docker ps -a -q)
                yes| docker container prune
                docker rmi -f $(docker images -q)
                cat /home/ubuntu/dockerhub/pass.txt | docker login -u "bohdan1993" --password-stdin
                docker pull bohdan1993/alpache:v${BUILD_NUMBER}
                docker run -d -p 80:80 bohdan1993/alpache:v${BUILD_NUMBER}
                echo "=== Deploy finished ================================================================================"
                ''', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }
    }
}
