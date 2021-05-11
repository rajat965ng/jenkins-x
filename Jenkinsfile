pipeline {
 agent any {

    try {

        stage('source'){
            echo "source checkout !!"
        }

    } catch (err) {

      echo "caught error: ${err}"
    }

    stage("notify"){
     echo "send notification !!"
    }

 }
}
