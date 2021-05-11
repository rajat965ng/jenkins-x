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
           echo "build stage !!"
        }
    }

    stage("notify"){
        steps {
           echo "send notification !!"
        }
    }

 }
}
