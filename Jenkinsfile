pipeline {
  agent any

  options {
    ansiColor('xterm') // Colored console output
    disableConcurrentBuilds() // Remove this line if you are fine with concurrent builds
    buildDiscarder(logRotator(numToKeepStr: '20')) // only keep artifacts of the last 20 builds
    timestamps() // print timestamps in the console output
  }

  // These parameters will appear in the Jenkins UI when you manually start a build
  parameters {
    booleanParam(name: 'RUN_ALL',           defaultValue: false, description: 'Run all stages')
    booleanParam(name: 'BOOTSTRAP',         defaultValue: true, description: 'Run the base application stack')
    booleanParam(name: 'PRE_BUILD_TESTS',   defaultValue: true,  description: 'Run pre-build tests (lint, audit, etc)')
    booleanParam(name: 'BUILD',             defaultValue: true,  description: 'Build and test the application image')
    booleanParam(name: 'PROMOTE',           defaultValue: false, description: 'Promote the image (e.g. push to the registry)')
    booleanParam(name: 'DEPLOY',            defaultValue: false, description: 'Deploy app to the passive side of the cluster')
    booleanParam(name: 'PUBLISH',           defaultValue: false, description: 'Publish the app (move the new version to the active side)')
  }

  stages {
    stage('Bootstrap') {
      when {
        anyOf {
          branch 'master'
          expression { return params.BOOTSTRAP }
          expression { return params.RUN_ALL }
        }
      }
      steps {
        sh "bnw_runner ./_pipeline/stage_bootstrap.sh"
      }
    }

    stage('Build') {
      when {
        anyOf {
          branch 'master'
          expression { return params.BUILD }
          expression { return params.RUN_ALL }
        }
      }
      steps {
        sh "bnw_runner ./_pipeline/stage_build.sh"
      }
    }

    stage('Promote') {
      when {
        anyOf {
          branch 'master'
          expression { return params.PROMOTE }
          expression { return params.RUN_ALL }
        }
      }
      steps {
        sh "bnw_runner ./_pipeline/stage_promote.sh"
      }
    }

    stage('Deploy') {
      when {
        anyOf {
          branch 'master'
          expression { return params.DEPLOY }
          expression { return params.RUN_ALL }
        }
      }
      steps {
        sh "bnw_runner ./_pipeline/stage_deploy.sh"
      }
    }

    stage('Publish') {
      when {
        anyOf {
          branch 'master'
          expression { return params.PUBLISH }
          expression { return params.RUN_ALL }
        }
      }
      steps {
        sh "bnw_runner ./_pipeline/stage_publish.sh"
      }
    }
  }
  // You can either capture post-cations here, after all stages, or after each
  // individual stage.
  post {
    // Only post to slack in case of failure
    failure {
      script {
        sh "bnw_runner ./_pipeline/utils/slack_notify.sh fail 'Build failed'"
      }
    }
    // We don't want to post a message after each successful build to reduce
    // noise in the slack channel. However, the block below posts to slack
    // if the run is successful and the previous run failed or was unstable.
    // See all options here: https://jenkins.io/doc/book/pipeline/syntax/#post
    fixed {
      script {
        sh "bnw_runner ./_pipeline/utils/slack_notify.sh success 'Build successful'"
      }
    }
  }
}
