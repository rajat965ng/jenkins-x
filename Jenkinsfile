pipeline {
 agent any

 stages {

    stage('source'){
        steps {
           cleanWs()
           git branch: 'master', url: 'https://github.com/rajat965ng/proximity-labs-challenge.git'
           sh 'ls -a '
           echo "source checkout !!"
        }
    }

    stage('build'){
        steps {

           sh 'ls -a '
           withDockerContainer('gradle') {
              sh 'build'
           }
        }
    }

    stage("notify"){
        steps {
           echo "send notification !!"
        }
    }

 }
}


