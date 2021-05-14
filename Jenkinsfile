pipeline {
 agent any

 environment {
    PROJECT_NAME = "GitSample"
    GIT_PAT = credentials('GIT_PAT')

 }
 stages {
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
           script {
            def text = readfile file: 'README.md'
            text = text.replaceAll('MS-TEMPLATE', $PROJECT_NAME)
            writeFile file:'README.md', text: text

            text = readfile file: 'pom.xml'
            text = text.replaceAll('ms-template', $PROJECT_NAME)
            writeFile file:'pom.xml', text: text
           }
        }
    }

    stage('git publisher') {
        agent {
          docker {
            image 'tutum/curl'
            reuseNode true
          }
        }
        steps {
            sh 'ls -a '
            sh 'echo $PROJECT_NAME'
            sh 'curl -X POST https://api.github.com/user/repos -H "Accept: application/vnd.github.v3+json" -H "Authorization: token $GIT_PAT_PSW" -H "Content-Type: application/json" -d \'{"name":"\'"$PROJECT_NAME"\'", "description":"Demo Git Repo !!", "homepage": "https://github.com","private": false,"auto_init":false}\' | tee output.json'
        }
    }

    stage("Initial Commit"){
        steps {
          sh 'ls -a '
          sh 'git config user.name "$GIT_PAT_USR"'
          sh 'git config user.password "$GIT_PAT_PSW"'
          sh 'git config user.email "$GIT_PAT_USR"@org.com'
          sh 'cat output.json | jq .clone_url'
          sh 'git remote set-url origin `cat output.json | jq -r .clone_url | sed s/github/$GIT_PAT_USR:$GIT_PAT_PSW@github/`'
          sh 'rm output.json && git add . && git commit -m "initial commit"'
          sh 'git push -u origin master'
        }
    }

 }
}


