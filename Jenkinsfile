pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building the container'
                sh "docker image build . -t lhr.ocir.io/intrnayak/oci-nvidia-docker-cpu-tensorflow-demo:$GIT_COMMIT"
            }        
        }
        stage('Push to registry') {
            steps {
                withCredentials([string(credentialsId: 'OCI_AUTH_TOKEN', variable: 'OCI_AUTH_TOKEN')]) {
                    sh "docker login lhr.ocir.io -u intrnayak/ramnath.nayak@oracle.com -p $OCI_AUTH_TOKEN"
                }
                sh "docker push lhr.ocir.io/intrnayak/oci-nvidia-docker-cpu-tensorflow-demo:$GIT_COMMIT"
                sh "docker tag lhr.ocir.io/intrnayak/oci-nvidia-docker-cpu-tensorflow-demo:$GIT_COMMIT lhr.ocir.io/intrnayak/oci-nvidia-docker-cpu-tensorflow-demo:latest"
                sh "docker push lhr.ocir.io/intrnayak/oci-nvidia-docker-cpu-tensorflow-demo:latest"
            }
        }
        stage('Deploy new image with rolling update') {
            steps {
                sh 'kubectl set image deployment oci-nvidia-docker-cpu-tensorflow-demo oci-nvidia-docker-cpu-tensorflow-demo=lhr.ocir.io/intrnayak/oci-nvidia-docker-cpu-tensorflow-demo:latest'
                sh 'kubectl rollout status deployment oci-nvidia-docker-cpu-tensorflow-demo'
                sh "kubectl label pods --overwrite --all git_commit=$GIT_COMMIT"
            }
        }
    }
}
