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

    stage('git publisher') {
        environment {
          GIT_PAT = credentials('GIT_PAT')
        }
        agent {
          docker {
            image 'tutum/curl'
            reuseNode true
          }
        }
        steps {
            sh 'ls -a '
            sh '''curl -i -X POST \'https://api.github.com/user/repos\' \\
                  -H \'Accept: application/vnd.github.v3+json\' \\
                  -H \'Authorization: Bearer $GIT_PAT_PSW\' \\
                  -H \'Content-Type: application/json\' \\
                  -d \'{"name":"GitSample", "description":"Demo Git Repo !!", "homepage": "https://github.com","private": false,"auto_init":true}\''''
        }
    }

    stage("notify"){
        steps {
           echo "send notification !!"
        }
    }

 }
}


