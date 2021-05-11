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
        def server = Artifactory.server "LocalArtifactory" // Create a new Artifactory for Gradle object
        def artifactoryGradle = Artifactory.newGradleBuild()
        artifactoryGradle.tool = "gradle4" //

        def buildInfo = Artifactory.newBuildInfo()
        buildInfo.env.capture = true
        artifactoryGradle.deployer.deployMavenDescriptors = true

        // extra gradle configurations
        artifactoryGradle.deployer.artifactDeploymentPatterns.addExclude("*.jar")
        artifactoryGradle.usesPlugin = false

        // run the Gradle piece to deploy
        artifactoryGradle.run buildFile: 'build.gradle' tasks: 'cleanartifactoryPublish' buildInfo: buildInfo

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

