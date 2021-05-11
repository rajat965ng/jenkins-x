pipeline {
 agent any

 stages {

    stage('source'){
        steps {
           cleanupWs()
           git branch: 'master', url: 'https://github.com/rajat965ng/proximity-labs-challenge.git'
           echo "source checkout !!"
        }
    }
    stage("notify"){
        steps {
           echo "send notification !!"
        }
    }

 }
}
