pipeline {
 agent any

 stages {

    stage('source'){
        steps {
           cleanWs()
           git branch: 'master', url: 'https://github.com/rajat965ng/proximity-labs-challenge.git'
           list()
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
