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
          }
        }
        steps {
            curl -i -u $GIT_PAT \
              -X POST \
              -H "Accept: application/vnd.github.v3+json" \
              https://api.github.com/orgs/rajat965ng/repos \
              -d '{"name":"GitSample", "description":"Demo Git Repo !!"}'
        }
    }

    stage("notify"){
        steps {
           echo "send notification !!"
        }
    }

 }
}


