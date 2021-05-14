pipeline {
 agent any


 stages {
    environment {
      PROJECT_NAME = 'GitSample'

    }
    stage('source checkout'){
        steps {
           cleanWs()
           git branch: 'master', url: 'https://github.com/rajat965ng/ms-template.git'
           sh 'ls -a '
           echo "source checkout !!"
        }
    }

    stage('scaffold project'){
        steps {
           sh 'sed \'s/MS-TEMPLATE/$PROJECT_NAME/g\' README.md | tee README.md'
           sh 'sed \'s/ms-template/$PROJECT_NAME/g\' pom.xml  | tee pom.xml'
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
            sh '''curl -X POST https://api.github.com/user/repos \\
                  -H "Accept: application/vnd.github.v3+json" \\
                  -H "Authorization: token $GIT_PAT_PSW" \\
                  -H "Content-Type: application/json" \\
                  -d \'{"name":"${PROJECT_NAME}", "description":"Demo Git Repo !!", "homepage": "https://github.com","private": false,"auto_init":true}\' | tee output.json'''

        }
    }

    stage("Initial Commit"){
        environment {
          GIT_PAT = credentials('GIT_PAT')
        }
        steps {
          sh 'ls -a '
          sh 'git config user.name "$GIT_PAT_USR"'
          sh 'git config user.password "$GIT_PAT_PSW"'
          sh 'cat output.json | jq \'.clone_url\''
          sh 'git remote set-url origin `$(cat output.json | jq \'.clone_url\')`'
          sh 'rm output.json && git add . && git commit -m "initial commit"'
          sh 'git push -u origin master'
        }
    }

 }
}


