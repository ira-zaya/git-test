pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh '''
                docker build -t alpache:v${BUILD_NUMBER} .
docker tag alpache:v${BUILD_NUMBER} bohdan1993/alpache:v${BUILD_NUMBER}
bash /home/ubuntu/dockerhub/rmi_dockerhub.sh
cat /home/ubuntu/dockerhub/pass.txt | docker login -u "bohdan1993" --password-stdin
docker push bohdan1993/alpache:v${BUILD_NUMBER}
docker image prune -a -f
echo "==================================================================================="
'''
            }
        }
        
        stage('Deploy') {
            steps {
                sshPublisher(publishers: [sshPublisherDesc(configName: 'web_srv', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '''docker stop $(docker ps -a -q)
yes| docker container prune
docker rmi -f $(docker images -q)
cat /home/ubuntu/dockerhub/pass.txt | docker login -u "bohdan1993" --password-stdin
docker pull bohdan1993/alpache:v${BUILD_NUMBER}
docker run -d -p 80:80 bohdan1993/alpache:v${BUILD_NUMBER}''', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }
    }
}
