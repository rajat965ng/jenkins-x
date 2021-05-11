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
           sh '${tool name: 'gradle', type: 'gradle'} build test'
        }
    }

    stage("notify"){
        steps {
           echo "send notification !!"
        }
    }

 }
}


repositories {
    mavenLocal()
    mavenCentral()
    maven {
        url = uri('http://repo.maven.apache.org/maven2')
    }
}

