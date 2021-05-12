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
        agent {
          docker {
            image 'gradle:6.7-jdk11'
                        // Run the container on the node specified at the top-level of the Pipeline, in the same workspace, rather than on a new node entirely:
            reuseNode true
          }
        }
        steps {

           sh 'ls -a '
           sh 'gradle build'
        }
    }

    stage("notify"){
        steps {
           echo "send notification !!"
        }
    }

 }
}


